-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/legend/view/LegendprizeView.lua

module("logic.extensions.legend.view.LegendprizeView", package.seeall)

local LegendprizeView = class("LegendprizeView", ViewComponent)

function LegendprizeView:ctor()
	LegendprizeView.super.ctor(self)
end

function LegendprizeView:buildUI()
	LegendprizeView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._tableGo = self:getGo("tableview")
	self._itemGo = self:getGo("tablecell")
	self._tableview = ScrollerList.create(self._tableGo, self._itemGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtTip = goutil.findChildTextComponent(self.mainGO, "txtTip")
end

function LegendprizeView:bindEvents()
	LegendprizeView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function LegendprizeView:unbindEvents()
	LegendprizeView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function LegendprizeView:destroyUI()
	LegendprizeView.super.destroyUI(self)
end

function LegendprizeView:onEnter()
	LegendprizeView.super.onEnter(self)

	local challengeId = self:getFirstParam()

	self._challengeId = challengeId

	local dataList = {}
	local cfg = LegendConfig.instance:getLegendChallengeCfg(challengeId)
	local stagecfgs = LegendConfig.instance:getLegendChallengeStageCfgList(challengeId)
	local haveSweep = false
	local cfgStageEnd = stagecfgs[#stagecfgs]

	if cfgStageEnd then
		local cfgTeam = LegendConfig.instance:getLegendChallengeTeamCfg(cfgStageEnd.teamId)

		if cfgTeam then
			local single = {}

			single.rewardStr = cfgTeam.reward
			single.isSweep = true
			haveSweep = true

			table.insert(dataList, single)
		end
	end

	if stagecfgs then
		for k, v in pairs(stagecfgs) do
			local stageId = v.stageId
			local cfgStage = LegendConfig.instance:getLegendChallengeStageCfg(challengeId, stageId)
			local cfgTeam = LegendConfig.instance:getLegendChallengeTeamCfg(cfgStage.teamId)

			if not string.nilorempty(cfgTeam.firstPassPrize) then
				if not (cfgTeam.firstPassPrize .. "#") then
					local rewardStr = ""

					rewardStr = rewardStr .. cfgTeam.reward

					if cfgTeam then
						local single = {}

						single.isSweep = false
						single.rewardStr = rewardStr
						single.stageId = stageId
						single.isPass = LegendModel.instance:isStagePass(challengeId, stageId)

						table.insert(dataList, single)
					end
				end
			end
		end
	end

	table.sort(dataList, function(a, b)
		if a.isSweep then
			return true
		end

		if b.isSweep then
			return false
		end

		return b.stageId < a.stageId
	end)

	self._txtTip.text = haveSweep and "首次通关后可马上获得<color=#60ee85>首通奖励</color>，通过全部关卡后可进行<color=#60ee85>扫荡</color>。" or "首次通关后可马上获得<color=#60ee85>首通奖励</color>"

	self._tableview:reloadData(dataList)
end

function LegendprizeView:onEnterFinished()
	LegendprizeView.super.onEnterFinished(self)
end

function LegendprizeView:onExit()
	LegendprizeView.super.onExit(self)
	self._tableview:dispose()
end

function LegendprizeView:onExitFinished()
	LegendprizeView.super.onExitFinished(self)
end

function LegendprizeView:_updateCell(view, cell, data)
	local txtName = goutil.findChildTextComponent(cell, "imgDes/name")
	local content = goutil.findChild(cell, "scroll/viewport/content")
	local item = goutil.findChild(cell, "itemCell")
	local goNotGet = goutil.findChild(cell, "state/notGet")
	local goGet = goutil.findChild(cell, "state/get")
	local goState = goutil.findChild(cell, "state")

	goutil.clearChildren(content)

	if data.isSweep == true then
		txtName.text = "扫荡奖励"

		goutil.setActive(goState, false)
	else
		txtName.text = string.format("第%s关首通", data.stageId)

		goutil.setActive(goState, true)
		goutil.setActive(goNotGet, not data.isPass)
		goutil.setActive(goGet, data.isPass)
	end

	local str2 = MaterialMgr.combineStrs(data.rewardStr)
	local rewardItems = MaterialMgr.changeItemStrArr(data.rewardStr)
	local length2 = #rewardItems

	for i = 1, length2 do
		if not string.nilorempty(rewardItems[i]) then
			local itemcell = goutil.cloneAndSetParent(item, content.transform)
			local mtcell = goutil.findChild(itemcell, "mtCell")

			MaterialMgr.setCellByCfg(rewardItems[i], mtcell)

			local imgPercent = goutil.findChild(itemcell, "imgPercent")

			imgPercent:SetActive(false)

			if data.isSweep == false then
				local stageId = data.stageId
				local cfgStage = LegendConfig.instance:getLegendChallengeStageCfg(self._challengeId, stageId)
				local cfgTeam = LegendConfig.instance:getLegendChallengeTeamCfg(cfgStage.teamId)
				local isPercent = false

				imgPercent:SetActive(isPercent)
			end
		end
	end
end

function LegendprizeView:_clearCell(cell)
	return
end

return LegendprizeView
