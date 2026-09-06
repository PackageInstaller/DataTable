-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonlords/view/LimitStageItemView.lua

module("logic.extensions.dragonlords.view.LimitStageItemView", package.seeall)

local LimitStageItemView = class("LimitStageItemView")

function LimitStageItemView:ctor(go, index)
	self.mainGo = go
	self._index = index
	self._passTxt = goutil.findChildTextComponent(go, "Text")
	self._lock = goutil.findChild(go, "lock")
	self._select = goutil.findChild(go, "select")
	self._icon = goutil.findChild(go, "bg/img")
end

function LimitStageItemView:initData()
	self._curStage = DrogonLordsModel.instance:getCurLimitStage()

	GameUtil.asBtn(self.mainGo):AddClickListener(self._onClick, self)

	local cfg = DragonLordsConfig.instance:getLimitChallengeCfg(self._index)

	MaterialMgr.setIcon(self._icon, MatType.Pet, checknumber(cfg.skinId))
	goutil.setActive(self._lock, false)
	goutil.setActive(self._select, false)
	self:_setState()

	self._passTxt.text = string.format("第%s层", self._index)
end

function LimitStageItemView:exit()
	GameUtil.asBtn(self.mainGo):RemoveClickListener()
	MaterialMgr.resetAll(self._icon)
end

function LimitStageItemView:_onClick()
	if self._index > self._curStage then
		UIStateManager.instance:push(ViewName.LookOverFormationView, self._index)
	elseif self._index == self._curStage then
		local actId = DrogonLordsModel.instance:getActivityId()

		DragonRespectChallengeAgent.instance:sendPM_DragonRespectChallengeInfoReq(actId)
	else
		FloatWordMgr.instance:show("已通关该关卡~")
	end
end

function LimitStageItemView:_setState()
	if self._index > self._curStage then
		-- block empty
	elseif self._index == self._curStage then
		goutil.setActive(self._select, true)
	else
		goutil.setActive(self._lock, true)
	end
end

return LimitStageItemView
