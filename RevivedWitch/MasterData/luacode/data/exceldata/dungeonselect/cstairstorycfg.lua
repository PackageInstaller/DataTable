-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/dungeonselect/cstairstorycfg.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cstairstorycfg = {}
cstairstorycfg.Data = {
[10001] = {id = 10001, storyName = "好心的树人", storyNameTextID = 1900963, storyContent = "路边树人叫住了你：“路过的旅人啊，您仍然可以保持人形，一定是受到祝福之人。请接受我的心意吧”", storyContentTextID = 1900908, optionOne = "接过苹果", optionOneTextID = 1900916, optionTwo = "婉言谢绝", optionTwoTextID = 1900924, optionOneImg1 = 10001, optionTwoImg2 = 10002}
, 
[10002] = {id = 10002, storyName = "向日葵歌唱家", storyNameTextID = 1900964, storyContent = "向日葵歌唱家在路边放声歌唱", storyContentTextID = 1900909, optionOne = "唱得真好", optionOneTextID = 1900917, optionTwo = "堵住耳朵", optionTwoTextID = 1900925, optionOneImg1 = 10001, optionTwoImg2 = 10002}
, 
[10003] = {id = 10003, storyName = "雪原狼群", storyNameTextID = 1900150, storyContent = "远处的雪原上传来了狼的叫声，声音越来越近……", storyContentTextID = 1900156, optionOne = "不予理会", optionOneTextID = 1900162, optionTwo = "隐藏气息", optionTwoTextID = 1900168, optionOneImg1 = 10001, optionTwoImg2 = 10002}
, 
[10004] = {id = 10004, storyName = "受伤的佣兵", storyNameTextID = 1900965, storyContent = "在探索的过程中，你发现了一位奄奄一息的雇佣兵……", storyContentTextID = 1900910, optionOne = "给予帮助", optionOneTextID = 1900918, optionTwo = "离开", optionTwoTextID = 1900169, optionOneImg1 = 10001, optionTwoImg2 = 10002}
, 
[10005] = {id = 10005, storyName = "雪中小屋", storyNameTextID = 1900152, storyContent = "在猛烈的暴风雪中，你四处寻找可以躲避的场所。这时你发现远处有一座破旧的木屋", storyContentTextID = 1900158, optionOne = "进入小屋", optionOneTextID = 1900164, optionTwo = "继续前进", optionTwoTextID = 1900170, optionOneImg1 = 10001, optionTwoImg2 = 10002}
, 
[10006] = {id = 10006, storyName = "神秘仪式", storyNameTextID = 1900153, storyContent = "在房间内，一群人正在进行着某种神秘的仪式。你心中掠过一丝不安……", storyContentTextID = 1900159, optionOne = "阻止他们", optionOneTextID = 1900165, optionTwo = "暗中观察", optionTwoTextID = 1900171, optionOneImg1 = 10001, optionTwoImg2 = 10002}
, 
[10007] = {id = 10007, storyName = "神秘门", storyNameTextID = 1900274, storyContent = "在角落，你发现了一道神秘的门", storyContentTextID = 1900280, optionOne = "打开隐藏门", optionOneTextID = 1900286, optionTwo = "离开", optionTwoTextID = 1900292, optionOneImg1 = 10001, optionTwoImg2 = 10002}
, 
[10008] = {id = 10008, storyName = "奇怪的雕像", storyNameTextID = 1900966, storyContent = "眼前出现了一座造型奇特的雕像", storyContentTextID = 1900911, optionOne = "摧毁雕像", optionOneTextID = 1900919, optionTwo = "向雕像祈祷", optionTwoTextID = 1900927, optionOneImg1 = 10001, optionTwoImg2 = 10002}
, 
[10009] = {id = 10009, storyName = "树上的松鼠", storyNameTextID = 1900967, storyContent = "你发现一只怪异的松鼠，它一边盯着树下的蛇，似乎要做些什么", storyContentTextID = 1900912, optionOne = "赶跑松鼠", optionOneTextID = 1900920, optionTwo = "置之不理", optionTwoTextID = 1900928, optionOneImg1 = 10001, optionTwoImg2 = 10002}
, 
[10010] = {id = 10010, storyName = "秘密洞穴", storyNameTextID = 1900277, storyContent = "在森林深处，你发现了一个隐秘的洞穴，地面上残留着脚印，直觉告诉你，这里似乎隐藏着秘密……", storyContentTextID = 1900283, optionOne = "探索洞穴", optionOneTextID = 1900923, optionTwo = "离开", optionTwoTextID = 1900931, optionOneImg1 = 10001, optionTwoImg2 = 10002}
, 
[10011] = {id = 10011, storyName = "传送迷宫", storyNameTextID = 1900278, storyContent = "你失足踏入了传送迷宫，暂时迷失了方向……", storyContentTextID = 1900913, optionOne = "直接踏入魔法阵", optionOneTextID = 1900921, optionTwo = "细心检查传送阵的指向", optionTwoTextID = 1900929, optionOneImg1 = 10001, optionTwoImg2 = 10002}
, 
[10012] = {id = 10012, storyName = "帮助村民", storyNameTextID = 1900279, storyContent = "在躲避风雪的洞窟中，村民们被冻得瑟瑟发抖……", storyContentTextID = 1900914, optionOne = "升起火堆", optionOneTextID = 1900922, optionTwo = "继续前进", optionTwoTextID = 1900930, optionOneImg1 = 10001, optionTwoImg2 = 10002}
}
cstairstorycfg.AllIds = {10001, 10002, 10003, 10004, 10005, 10006, 10007, 10008, 10009, 10010, 10011, 10012}
return cstairstorycfg

