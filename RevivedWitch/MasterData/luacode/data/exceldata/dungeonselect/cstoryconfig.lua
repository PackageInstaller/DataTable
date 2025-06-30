-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/dungeonselect/cstoryconfig.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cstoryconfig = {}
cstoryconfig.Data = {
[10001] = {id = 10001, storyName = "路边的老人", storyNameTextID = 1900148, storyContent = "路边的一位老妇人叫住了你：“这是祝福的苹果，请收下它吧。”", storyContentTextID = 1900154, optionOne = "接过苹果", optionOneTextID = 1900160, optionTwo = "婉言谢绝", optionTwoTextID = 1900166, optionOneImg1 = 10001, optionTwoImg2 = 10002}
, 
[10002] = {id = 10002, storyName = "秘密洞穴", storyNameTextID = 1900149, storyContent = "在森林深处你发现了一个隐秘的洞穴，直觉告诉你这里面似乎隐藏着秘密……", storyContentTextID = 1900155, optionOne = "探索洞穴", optionOneTextID = 1900161, optionTwo = "离开", optionTwoTextID = 1900167, optionOneImg1 = 10001, optionTwoImg2 = 10002}
, 
[10003] = {id = 10003, storyName = "雪原狼群", storyNameTextID = 1900150, storyContent = "远处的雪原上传来了狼的叫声，声音越来越近……", storyContentTextID = 1900156, optionOne = "不予理会", optionOneTextID = 1900162, optionTwo = "隐藏气息", optionTwoTextID = 1900168, optionOneImg1 = 10001, optionTwoImg2 = 10002}
, 
[10004] = {id = 10004, storyName = "上锁之门", storyNameTextID = 1900151, storyContent = "在探索的过程中，你发现了一道上了锁的门，散发出未知的神秘气息", storyContentTextID = 1900157, optionOne = "寻找开关", optionOneTextID = 1900163, optionTwo = "离开", optionTwoTextID = 1900169, optionOneImg1 = 10001, optionTwoImg2 = 10002}
, 
[10005] = {id = 10005, storyName = "雪中小屋", storyNameTextID = 1900152, storyContent = "在猛烈的暴风雪中，你四处寻找可以躲避的场所。这时你发现远处有一座破旧的木屋", storyContentTextID = 1900158, optionOne = "进入小屋", optionOneTextID = 1900164, optionTwo = "继续前进", optionTwoTextID = 1900170, optionOneImg1 = 10001, optionTwoImg2 = 10002}
, 
[10006] = {id = 10006, storyName = "神秘仪式", storyNameTextID = 1900153, storyContent = "在房间内，一群人正在进行着某种神秘的仪式。你心中掠过一丝不安……", storyContentTextID = 1900159, optionOne = "阻止他们", optionOneTextID = 1900165, optionTwo = "暗中观察", optionTwoTextID = 1900171, optionOneImg1 = 10001, optionTwoImg2 = 10002}
, 
[10007] = {id = 10007, storyName = "神秘门", storyNameTextID = 1900274, storyContent = "在角落，你发现了一道神秘的门", storyContentTextID = 1900280, optionOne = "打开隐藏门", optionOneTextID = 1900286, optionTwo = "离开", optionTwoTextID = 1900292, optionOneImg1 = 10001, optionTwoImg2 = 10002}
, 
[10008] = {id = 10008, storyName = "神秘仪式", storyNameTextID = 1900275, storyContent = "在房间内，一群人正在进行着某种神秘的仪式。你心中掠过一丝不安……", storyContentTextID = 1900281, optionOne = "阻止他们", optionOneTextID = 1900287, optionTwo = "暗中观察", optionTwoTextID = 1900293, optionOneImg1 = 10001, optionTwoImg2 = 10002}
, 
[10009] = {id = 10009, storyName = "路边的老人", storyNameTextID = 1900276, storyContent = "路边的一位老妇人叫住了你：“要来一个刚摘下来的苹果吗？”", storyContentTextID = 1900282, optionOne = "接过苹果", optionOneTextID = 1900288, optionTwo = "婉言谢绝", optionTwoTextID = 1900294, optionOneImg1 = 10001, optionTwoImg2 = 10002}
, 
[10010] = {id = 10010, storyName = "秘密洞穴", storyNameTextID = 1900277, storyContent = "在森林深处你发现了一个隐秘的洞穴，地面上残留着脚印，直觉告诉你这里面似乎隐藏着秘密……", storyContentTextID = 1900283, optionOne = "探索洞穴", optionOneTextID = 1900289, optionTwo = "离开", optionTwoTextID = 1900295, optionOneImg1 = 10001, optionTwoImg2 = 10002}
, 
[10011] = {id = 10011, storyName = "雪中小屋", storyNameTextID = 1900278, storyContent = "在猛烈的暴风雪中，你四处寻找可以躲避的场所。这时你发现远处有一座奇怪的木屋", storyContentTextID = 1900284, optionOne = "敲门", optionOneTextID = 1900290, optionTwo = "继续前进", optionTwoTextID = 1900296, optionOneImg1 = 10001, optionTwoImg2 = 10002}
, 
[10012] = {id = 10012, storyName = "雪原狼群", storyNameTextID = 1900279, storyContent = "雪原上传来了狼的叫声，但距离似乎还很远……", storyContentTextID = 1900285, optionOne = "继续前进", optionOneTextID = 1900291, optionTwo = "隐藏气息", optionTwoTextID = 1900297, optionOneImg1 = 10001, optionTwoImg2 = 10002}
}
cstoryconfig.AllIds = {10001, 10002, 10003, 10004, 10005, 10006, 10007, 10008, 10009, 10010, 10011, 10012}
return cstoryconfig

