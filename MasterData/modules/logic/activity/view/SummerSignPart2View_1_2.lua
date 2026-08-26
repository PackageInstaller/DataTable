-- chunkname: @modules/logic/activity/view/SummerSignPart2View_1_2.lua

module("modules.logic.activity.view.SummerSignPart2View_1_2", package.seeall)

local SummerSignPart2View_1_2 = class("SummerSignPart2View_1_2", ActivityNorSignViewBase_1_2)

function SummerSignPart2View_1_2:_editableInitView()
	gohelper.setActive(self._gorule, false)

	self._actId = ActivityEnum.Activity.SummerSignPart2_1_2

	Activity101Rpc.instance:sendGet101InfosRequest(self._actId)
	self._titleicon:LoadImage(ResUrl.getActivityLangIcon("qiandao_biaoti_xia"))
	self._simagebanner:LoadImage(ResUrl.getActivityFullBg("qiandao_bg_xia"))
end

return SummerSignPart2View_1_2
