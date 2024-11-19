# 说明
要完成这个项目，你需要编写一个脚本，为用户生成一个1到1000之间的随机数让他们猜。创建一个`number_guess`数据库来存储用户故事中建议的信息。使用`psql --username=freecodecamp --dbname=postgres`连接到交互式psql shell来创建数据库。在你的脚本中，你可以创建一个`PSQL`变量来查询数据库，像这样：`PSQL="psql --username=freecodecamp --dbname=<database_name> -t --no-align -c"`。你的脚本应该只询问用户输入用户名和进行猜测。你的脚本的输出应该严格按照下面用户故事中的描述，不要有任何额外的内容。当脚本具备相应功能时，测试会向数据库添加用户，你可以随意删除这些用户。在脚本完全正常工作之前，一些与脚本相关的用户故事可能无法通过。别忘了经常提交你的工作。

**注意：** 如果你离开虚拟机，你的数据库可能不会被保存。你可以在bash终端（不是psql终端）中输入`pg_dump -cC --inserts -U freecodecamp number_guess > number_guess.sql`来进行数据库转储。它会将重建数据库的命令保存在`number_guess.sql`中。该文件将保存在输入命令的位置。如果是在`project`文件夹内的任何位置，该文件将保存在虚拟机中。你可以在存有`.sql`文件的终端中输入`psql -U postgres < number_guess.sql`来重建数据库。

如果你要在freeCodeCamp.org上保存进度，在通过所有测试后，按照上述说明保存数据库的转储。将`number_guess.sql`文件以及`number_guess.sh`文件的最终版本保存在公共仓库中，并在freeCodeCamp.org上提交其URL。

完成以下任务：
* 在`project`文件夹中创建一个`number_guessing_game`文件夹用于你的程序
* 在`number_guessing_game`文件夹中创建`number_guess.sh`并赋予其可执行权限
* 你的脚本应该在文件顶部有一个使用`#!/bin/bash`的shebang
* 将`number_guessing_game`文件夹转换为git仓库
* 你的git仓库应该至少有五次提交
* 你的脚本应该随机生成一个用户需要猜测的数字
* 运行脚本时，你应该提示用户输入用户名，显示`Enter your username:`，并接受用户名输入。你的数据库应该允许22个字符的用户名
* 如果该用户名之前使用过，应该打印`Welcome back, <username>! You have played <games_played> games, and your best game took <best_game> guesses.`，其中`<username>`是数据库中的用户名，`<games_played>`是该用户玩过的游戏总数，`<best_game>`是该用户赢得游戏所用的最少猜测次数
* 如果用户名之前未使用过，你应该打印`Welcome, <username>! It looks like this is your first time here.`
* 下一行应该打印`Guess the secret number between 1 and 1000:`并读取用户输入
* 在他们猜到秘密数字之前，如果前一个输入比秘密数字大，应该打印`It's lower than that, guess again:`，如果前一个输入比秘密数字小，应该打印`It's higher than that, guess again:`。每次都要求输入，直到他们输入正确的秘密数字。
* 如果输入的猜测不是整数，应该打印`That is not an integer, guess again:`
* 当猜到秘密数字时，你的脚本应该打印`You guessed it in <number_of_guesses> tries. The secret number was <secret_number>. Nice job!`然后结束运行
* 第一次提交的消息应该是`Initial commit`
* 其余的提交消息应该以`fix:`、`feat:`、`refactor:`、`chore:`或`test:`开头
* 你应该在`main`分支上完成你的项目，你的工作树应该是干净的，并且不应该有任何未提交的更改