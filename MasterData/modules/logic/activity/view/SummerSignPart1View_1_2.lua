-- chunkname: @modules/logic/activity/view/SummerSignPart1View_1_2.lua

module("modules.logic.activity.view.SummerSignPart1View_1_2", package.seeall)

local SummerSignPart1View_1_2 = class("SummerSignPart1View_1_2", ActivityNorSignViewBase_1_2)

function SummerSignPart1View_1_2:_editableInitView()
	gohelper.setActive(self._gorule, false)

	self._actId = ActivityEnum.Activity.SummerSignPart1_1_2

	Activity101Rpc.instance:sendGet101InfosRequest(self._actId)
	self._titleicon:LoadImage(ResUrl.getActivityLangIcon("qiandao_biaoti_shang"))
	self._simagebanner:LoadImage(ResUrl.getActivityFullBg("qiandao_bg_shang"))
end

return SummerSignPart1View_1_2
