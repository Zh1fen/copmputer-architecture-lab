# PowerShell 脚本：初始化 Git 仓库并推送到远程

# --- 准备工作 ---

# 1. 初始化本地 Git 仓库
# 在当前目录下创建一个新的 .git 文件夹，用来跟踪项目变更。
git init

# 2. 创建 .gitignore 文件
# 这个文件告诉 Git 哪些文件或文件夹应该被忽略，不要纳入版本控制。
# 这里我们忽略 Gowin IDE 生成的 impl/ 目录和用户配置文件。
# 使用 Set-Content 命令创建并写入内容。
Set-Content -Path .gitignore -Value "# Gowin IDE generated files`nimpl/`n*.gprj.user"

echo ".gitignore file created."

# --- 配置用户信息 ---
# 在提交代码前，你需要告诉 Git 你的名字和邮箱。
# 这会作为每次提交的“签名”。
# !! "Your Name" 和 "you@example.com" 是自己的信息 !!
git config --global user.name "Zh1fen"
git config --global user.email "y2130055713@qq.com"

echo "Git user info configured."

# --- 提交到本地仓库 ---

# 3. 添加所有文件到暂存区
# `git add .` 命令会暂存当前目录下所有的变更。
git add .

# 4. 提交暂存的文件
# `git commit` 将暂存区的内容创建一次新的提交记录。
# -m "Initial commit" 是本次提交的说明信息。
git commit -m "Initial commit"

echo "Files committed to local repository."

# --- 推送到远程仓库 ---

# 5. 关联远程仓库
# 将本地仓库与一个远程仓库（如 GitHub）关联起来。
# "origin" 是远程仓库的默认别名。
# !! 请确保下面的 URL 是你自己的远程仓库地址 !!
git remote add origin https://github.com/Zh1fen/copmputer-architecture-lab.git

# 6. 推送本地提交到远程仓库
# `git push` 命令将本地的提交上传到远程仓库。
# -u origin master 会将本地的 master 分支与远程的 origin/master 分支关联起来，
# 这样以后你就可以直接使用 `git push` 和 `git pull`。
git push -u origin master

echo "Local repository pushed to remote successfully!"

# --- 可视化结果 ---

# 7. 显示提交日志
# --oneline: 以单行简洁模式显示
# --graph: 显示提交历史的 ASCII 图
# --decorate: 显示分支和标签名
echo "Git commit history:"
git log --oneline --graph --decorate
