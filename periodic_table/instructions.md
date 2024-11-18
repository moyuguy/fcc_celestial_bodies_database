# 说明

您将从一个包含一些化学元素信息的 periodic_table 数据库开始。您可以在终端中输入 `psql --username=freecodecamp --dbname=periodic_table` 来连接数据库。您可能需要先熟悉一下现有的表格、列和行。请阅读以下说明并完成用户故事以完成项目。在其他用户故事完成之前，某些测试可能无法通过。祝您好运！
### 第1部分：修复数据库
数据库中存在一些需要修复或更改的错误。请参见下面的用户故事了解需要更改的内容。
### 第2部分：创建git仓库
您需要制作一个小型bash程序。代码需要用git进行版本控制，所以您需要将建议的文件夹转换为git仓库。
### 第3部分：创建脚本
最后，您需要制作一个脚本，该脚本接受原子序数、符号或元素名称作为参数，并输出有关给定元素的一些信息。在脚本中，您可以这样创建用于查询数据库的PSQL变量：`PSQL="psql --username=freecodecamp --dbname=<database_name> -t --no-align -c"`，如果需要可以添加更多标志。

## 注意事项：
如果您离开虚拟机，数据库可能不会被保存。您可以通过在bash终端（而不是psql终端）中输入 `pg_dump -cC --inserts -U freecodecamp periodic_table > periodic_table.sql` 来创建数据库转储。它将把重建数据库的命令保存在 periodic_table.sql 中。该文件将保存在输入命令的位置。如果是在项目文件夹内的任何位置，文件将保存在虚拟机中。您可以通过在包含.sql文件的终端中输入 `psql -U postgres < periodic_table.sql `来重建数据库。
如果您在 freeCodeCamp.org 上保存进度，在通过所有测试后，请按照上述说明保存数据库转储。将 periodic_table.sql 文件以及 element.sh 文件的最终版本保存在公共仓库中，并在 freeCodeCamp.org 上提交其URL。

## 需要完成的任务：

- 您应该将 weight 列重命名为 atomic_mass
- 您应该将 melting_point 列重命名为 melting_point_celsius，将 boiling_point 列重命名为 boiling_point_celsius
- melting_point_celsius 和 boiling_point_celsius 列不应接受空值
- 您应该为 elements 表中的 symbol 和 name 列添加 UNIQUE 约束
- symbol 和 name 列应具有 NOT NULL 约束
- 您应该将 properties 表中的 atomic_number 列设置为外键，引用 elements 表中的同名列
- 您应该创建一个 types 表来存储三种元素类型
- types 表应该有一个作为主键的整数类型 type_id 列
- types 表应该有一个不能为空的 VARCHAR 类型的 type 列。它将存储 properties 表中 type 列的不同类型
- 您应该向 types 表添加三行，其值是 properties 表中的三种不同类型
- properties 表应该有一个 type_id 外键列，引用 types 表中的 type_id 列。它应该是一个带有 NOT NULL 约束的 INT
- properties 表中的每一行都应该有一个 type_id 值，链接到 types 表中的正确类型
- 您应该将 elements 表中所有 symbol 值的第一个字母大写。注意只大写第一个字母，不要更改其他字母
- 您应该删除 atomic_mass 列中每行小数点后的所有尾随零。您可能需要将数据类型调整为 DECIMAL。最终值应该在 atomic_mass.txt 文件中
- 您应该将原子序数为9的元素添加到数据库中。它的名称是 Fluorine，符号是 F，质量是 18.998，熔点是 -220，沸点是 -188.1，它是一个非金属
- 您应该将原子序数为10的元素添加到数据库中。它的名称是 Neon，符号是 Ne，质量是 20.18，熔点是 -248.6，沸点是 -246.1，它是一个非金属
- 您应该在项目文件夹中创建一个 periodic_table 文件夹，并通过 git init 将其转换为git仓库
- 您的仓库应该有一个包含所有提交的 main 分支
- 您的 periodic_table 仓库应该至少有五次提交
- 您应该在仓库文件夹中创建一个 element.sh 文件，用于我想让您制作的程序
- 您的脚本(.sh)文件应该具有可执行权限
- 如果您运行 ./element.sh，它应该只输出 "Please provide an element as an argument."（请提供一个元素作为参数）并结束运行。
- 如果您运行 ./element.sh 1、./element.sh H 或 ./element.sh Hydrogen，它应该只输出 "The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius."（原子序数为1的元素是氢(H)。它是一种非金属，质量为1.008原子质量单位。氢的熔点为-259.1摄氏度，沸点为-252.9摄氏度。）
- 如果您使用另一个元素作为输入运行 ./element.sh 脚本，您应该得到相同的输出格式，但显示与给定元素相关的信息。
- 如果输入到您的 element.sh 脚本的参数在数据库中不存在（作为原子序数、符号或名称），唯一的输出应该是 "I could not find that element in the database."（我在数据库中找不到该元素。）
- 您仓库中第一次提交的消息应该是 "Initial commit"
- 其余的提交消息应该以 fix:、feat:、refactor:、chore: 或 test: 开头
- 您应该从两个表中删除原子序数为1000的不存在的元素
- 您的 properties 表不应该有 type 列
- 您应该在 main 分支上完成项目。您的工作树应该是干净的，并且不应该有任何未提交的更改