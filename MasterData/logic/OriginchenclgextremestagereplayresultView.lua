-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originchenclg/view/OriginchenclgextremestagereplayresultView.lua

module("logic.extensions.originchenclg.view.OriginchenclgextremestagereplayresultView", package.seeall)

local OriginchenclgextremestagereplayresultView = class("OriginchenclgextremestagereplayresultView", OriginchenclgextremestageresultView)

function OriginchenclgextremestagereplayresultView:buildUI()
	OriginchenclgextremestagereplayresultView.super.buildUI(self)
	GameUtil.SetActive(self._btnAgain, false)

	if self._btnSure then
		local pos = GameUtil.getAnchoredPos(self._btnSure)

		if pos then
			GameUtil.setAnchoredPos(self._btnSure, 0, pos.y)
		end
	end
end

function OriginchenclgextremestagereplayresultView:onEnter()
	OriginchenclgextremestageresultView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._stageId = params[2]
	self._stageInfo = params[3]

	self:_updateReplayUI()
end

function OriginchenclgextremestagereplayresultView:_updateReplayUI()
	local totalNum = 0
	local stageCfg = OriginChenClgConfig.instance:getExtremeStageCfg(self._activityId, self._stageId)

	if stageCfg then
		local creepsCfg = OriginChenClgConfig.instance:getCreepsCfg(stageCfg.creepsMasterId)

		if creepsCfg then
			for _, v in ipairs(creepsCfg) do
				if v.posId > 0 then
					totalNum = totalNum + 1
				end
			end
		end
	end

	if self._txtKill then
		self._txtKill.text = langPara("击败所有敌人（<color=#ff4d29>{0}</color>/{1}）", totalNum, totalNum)
	end

	GameUtil.SetActive(self._tagReachGo, true)
	self._scrollerList:reloadData(self._stageInfo.lockRaceIds)

	local suit = self._stageInfo and checknumber(self._stageInfo.suit) or 0

	GameUtil.SetActive(self._tagBuffGo, suit > 0)

	if suit > 0 and self._tagBuffChange then
		self._tagBuffChange:SetState(suit - 1)
	end
end

function OriginchenclgextremestagereplayresultView:bindEvents()
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
end

function OriginchenclgextremestagereplayresultView:unbindEvents()
	self._btnSure:RemoveClickListener()
end

function OriginchenclgextremestagereplayresultView:_onClickbtnSure()
	self:close()
end

return OriginchenclgextremestagereplayresultView
