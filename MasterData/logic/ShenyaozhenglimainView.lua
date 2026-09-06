-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shenyaozhengli/view/ShenyaozhenglimainView.lua

module("logic.extensions.shenyaozhengli.view.ShenyaozhenglimainView", package.seeall)

local ShenyaozhenglimainView = class("ShenyaozhenglimainView", LordNoahMainView)

function ShenyaozhenglimainView:buildUI()
	ShenyaozhenglimainView.super.buildUI(self)

	self._txtName = self:getTxt("info/txtName")
end

function ShenyaozhenglimainView:refreshViewByCfg()
	ShenyaozhenglimainView.super.refreshViewByCfg(self)

	self._txtName.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, self._skinId)
	self._txtLeftTime.text = TimeGateController.instance:getActTimeShow(self._actId)
end

function ShenyaozhenglimainView:_getActivityId()
	return 135003
end

function ShenyaozhenglimainView:onClickStart()
	UIStateManager.instance:push(ViewName.ShenyaozhenglichallengeView)
end

return ShenyaozhenglimainView
