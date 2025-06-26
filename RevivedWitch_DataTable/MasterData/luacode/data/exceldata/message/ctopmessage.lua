-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/message/ctopmessage.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ctopmessage = {}
ctopmessage.Data = {
[200001] = {id = 200001, msgTitle = "", msgTitleTextID = -1, msgMain = "解锁传送点：", msgMainTextID = 700232, msgNum = "$parameter1$", msgNumTextID = 700264, msgType = 1}
, 
[200002] = {id = 200002, msgTitle = "", msgTitleTextID = -1, msgMain = "主线：伊敏瑟伦镜片回收", msgMainTextID = 700233, msgNum = " $parameter1$ / $parameter2$", msgNumTextID = 700265, msgType = 2}
, 
[200003] = {id = 200003, msgTitle = "", msgTitleTextID = -1, msgMain = "解锁传送点：", msgMainTextID = 700234, msgNum = "$parameter1$", msgNumTextID = 700266, msgType = 1}
, 
[200004] = {id = 200004, msgTitle = "", msgTitleTextID = -1, msgMain = "祈愿", msgMainTextID = 700235, msgNum = " $parameter1$ / $parameter2$", msgNumTextID = 700267, msgType = 2}
, 
[200005] = {id = 200005, msgTitle = "", msgTitleTextID = -1, msgMain = "主线：", msgMainTextID = 700236, msgNum = "$parameter1$完成", msgNumTextID = 700268, msgType = 1}
, 
[200006] = {id = 200006, msgTitle = "", msgTitleTextID = -1, msgMain = "主线：镜片收集", msgMainTextID = 700237, msgNum = " $parameter1$ / $parameter2$", msgNumTextID = 700269, msgType = 2}
, 
[200007] = {id = 200007, msgTitle = "", msgTitleTextID = -1, msgMain = "祈愿：胜利女神·一", msgMainTextID = 700238, msgNum = " $parameter1$ / $parameter2$", msgNumTextID = 700270, msgType = 2}
, 
[200008] = {id = 200008, msgTitle = "", msgTitleTextID = -1, msgMain = "祈愿：胜利女神·二", msgMainTextID = 700239, msgNum = " $parameter1$ / $parameter2$", msgNumTextID = 700271, msgType = 2}
, 
[200009] = {id = 200009, msgTitle = "", msgTitleTextID = -1, msgMain = "祈愿：梦境探索", msgMainTextID = 700240, msgNum = " $parameter1$ / $parameter2$", msgNumTextID = 700272, msgType = 2}
, 
[200010] = {id = 200010, msgTitle = "", msgTitleTextID = -1, msgMain = "祈愿：玛那收集", msgMainTextID = 700241, msgNum = " $parameter1$ / $parameter2$", msgNumTextID = 700273, msgType = 2}
, 
[200011] = {id = 200011, msgTitle = "", msgTitleTextID = -1, msgMain = "祈愿：怪物猎手·一", msgMainTextID = 700242, msgNum = " $parameter1$ / $parameter2$", msgNumTextID = 700274, msgType = 2}
, 
[200012] = {id = 200012, msgTitle = "", msgTitleTextID = -1, msgMain = "祈愿：怪物猎手·二", msgMainTextID = 700243, msgNum = " $parameter1$ / $parameter2$", msgNumTextID = 700275, msgType = 2}
, 
[200013] = {id = 200013, msgTitle = "", msgTitleTextID = -1, msgMain = "祈愿：日常探索·一", msgMainTextID = 700244, msgNum = " $parameter1$ / $parameter2$", msgNumTextID = 700276, msgType = 2}
, 
[200014] = {id = 200014, msgTitle = "", msgTitleTextID = -1, msgMain = "祈愿：日常探索·二", msgMainTextID = 700245, msgNum = " $parameter1$ / $parameter2$", msgNumTextID = 700277, msgType = 2}
, 
[200015] = {id = 200015, msgTitle = "", msgTitleTextID = -1, msgMain = "祈愿：人偶强化", msgMainTextID = 700246, msgNum = " $parameter1$ / $parameter2$", msgNumTextID = 700278, msgType = 2}
, 
[200016] = {id = 200016, msgTitle = "", msgTitleTextID = -1, msgMain = "祈愿：装备强化·一", msgMainTextID = 700247, msgNum = " $parameter1$ / $parameter2$", msgNumTextID = 700279, msgType = 2}
, 
[200017] = {id = 200017, msgTitle = "", msgTitleTextID = -1, msgMain = "祈愿：装备收集", msgMainTextID = 700248, msgNum = " $parameter1$ / $parameter2$", msgNumTextID = 700280, msgType = 2}
, 
[200018] = {id = 200018, msgTitle = "", msgTitleTextID = -1, msgMain = "祈愿：装备强化·二", msgMainTextID = 700249, msgNum = " $parameter1$ / $parameter2$", msgNumTextID = 700281, msgType = 2}
, 
[200019] = {id = 200019, msgTitle = "", msgTitleTextID = -1, msgMain = "祈愿：装备收集·三", msgMainTextID = 700250, msgNum = " $parameter1$ / $parameter2$", msgNumTextID = 700282, msgType = 2}
, 
[200020] = {id = 200020, msgTitle = "", msgTitleTextID = -1, msgMain = "祈愿：怪物猎手·三", msgMainTextID = 700251, msgNum = " $parameter1$ / $parameter2$", msgNumTextID = 700283, msgType = 2}
, 
[200021] = {id = 200021, msgTitle = "", msgTitleTextID = -1, msgMain = "祈愿：胜利女神·三", msgMainTextID = 700252, msgNum = " $parameter1$ / $parameter2$", msgNumTextID = 700284, msgType = 2}
, 
[200022] = {id = 200022, msgTitle = "", msgTitleTextID = -1, msgMain = "祈愿：人偶突破", msgMainTextID = 700253, msgNum = " $parameter1$ / $parameter2$", msgNumTextID = 700285, msgType = 2}
, 
[200023] = {id = 200023, msgTitle = "", msgTitleTextID = -1, msgMain = "祈愿：召唤大师", msgMainTextID = 700254, msgNum = " $parameter1$ / $parameter2$", msgNumTextID = 700286, msgType = 2}
, 
[200024] = {id = 200024, msgTitle = "", msgTitleTextID = -1, msgMain = "主线：玛那的运用·一", msgMainTextID = 700255, msgNum = " $parameter1$ / $parameter2$", msgNumTextID = 700287, msgType = 2}
, 
[200025] = {id = 200025, msgTitle = "", msgTitleTextID = -1, msgMain = "主线：玛那的运用·二", msgMainTextID = 700256, msgNum = " $parameter1$ / $parameter2$", msgNumTextID = 700288, msgType = 2}
, 
[200026] = {id = 200026, msgTitle = "", msgTitleTextID = -1, msgMain = "主线：玛那的运用·三", msgMainTextID = 700257, msgNum = " $parameter1$ / $parameter2$", msgNumTextID = 700289, msgType = 2}
, 
[200027] = {id = 200027, msgTitle = "", msgTitleTextID = -1, msgMain = "支线：", msgMainTextID = 700258, msgNum = "$parameter1$完成", msgNumTextID = 700290, msgType = 2}
, 
[200028] = {id = 200028, msgTitle = "", msgTitleTextID = -1, msgMain = "已领取：", msgMainTextID = 700259, msgNum = " $parameter1$", msgNumTextID = 700291, msgType = 1}
, 
[200029] = {id = 200029, msgTitle = "", msgTitleTextID = -1, msgMain = "主线：玛那的运用·四", msgMainTextID = 700260, msgNum = " $parameter1$ / $parameter2$", msgNumTextID = 700292, msgType = 2}
, 
[200030] = {id = 200030, msgTitle = "", msgTitleTextID = -1, msgMain = "主线：强化装备", msgMainTextID = 700261, msgNum = " $parameter1$ / $parameter2$", msgNumTextID = 700293, msgType = 2}
, 
[200031] = {id = 200031, msgTitle = "", msgTitleTextID = -1, msgMain = "主线：上限突破", msgMainTextID = 700262, msgNum = "完成", msgNumTextID = 700294, msgType = 1}
, 
[200032] = {id = 200032, msgTitle = "", msgTitleTextID = -1, msgMain = "角色剧情：", msgMainTextID = 700263, msgNum = "$parameter1$完成", msgNumTextID = 700295, msgType = 2}
, 
[200033] = {id = 200033, msgTitle = "", msgTitleTextID = -1, msgMain = "成就达成：", msgMainTextID = 700780, msgNum = "$parameter1$", msgNumTextID = 700781, msgType = 1}
}
ctopmessage.AllIds = {200001, 200002, 200003, 200004, 200005, 200006, 200007, 200008, 200009, 200010, 200011, 200012, 200013, 200014, 200015, 200016, 200017, 200018, 200019, 200020, 200021, 200022, 200023, 200024, 200025, 200026, 200027, 200028, 200029, 200030, 200031, 200032, 200033}
return ctopmessage

