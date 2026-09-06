-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexingjiangclg/view/DivinexjClgInfoView.lua

module("logic.extensions.divinexingjiangclg.view.DivinexjClgInfoView", package.seeall)

local DivinexjClgInfoView = class("DivinexjClgInfoView", ViewComponent)

function DivinexjClgInfoView:ctor()
	DivinexjClgInfoView.super.ctor(self)
end

function DivinexjClgInfoView:buildUI()
	DivinexjClgInfoView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnChallenge = self:getBtn("btnChallenge")
	self._btnSwitch = self:getBtn("btnSwitch")
	self._txtName = self:getTxt("bgName/txtName")
	self._icon = self:getGo("icon"):GetComponent(ComponentType.UIImageSpriteChange)
	self._fmtList = {}

	for i = 1, 9 do
		local go = self:getGo("main/fmt/cell_" .. i)
		local element = {}

		element.go = go
		element.tagTop = goutil.findChild(go, "tag/tagTop")
		element.tagBottom = goutil.findChild(go, "tag/tagBottom")
		element.txtTop = goutil.findChildTextComponent(go, "tag/tagTop/txt")
		element.txtBottom = goutil.findChildTextComponent(go, "tag/tagBottom/txt")

		table.insert(self._fmtList, element)
	end

	self._txtDesc1 = self:getTxt("main/txtDesc1")
	self._txtDesc2 = self:getTxt("main/txtDesc2")
	self._txtDesc3 = self:getTxt("main/txtDesc3")
	self._txtDesc4 = self:getTxt("main/txtDesc4")
	self._txtTip1 = self:getTxt("main/txtTip1")
	self._txtTip2 = self:getTxt("main/txtTip2")
	self._txtTip3 = self:getTxt("main/txtTip3")
	self._txtTip4 = self:getTxt("main/txtTip4")
end

function DivinexjClgInfoView:bindEvents()
	DivinexjClgInfoView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
	GameUtil.addClickHandler(self._btnSwitch, self._onClickSwitch, self)
end

function DivinexjClgInfoView:unbindEvents()
	DivinexjClgInfoView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnSwitch)
end

function DivinexjClgInfoView:onEnter()
	DivinexjClgInfoView.super.onEnter(self)

	local param = self:getOpenParam()

	self._activityId = param[1]
	self._stageId = param[2]
	self._cfgStage = DivineXingJiangClgConfig.instance:getStageCfg(self._activityId, self._stageId)
	self._cfgSameTeam = DivineXingJiangClgConfig.instance:getSameTeamStageCfg(self._activityId, self._stageId)
	self._cfgStarAtlas = DivineXingJiangClgConfig.instance:getStarAtlasCfg(self._cfgStage.starAtlasId)

	self:_updateView()
end

function DivinexjClgInfoView:onExit()
	DivinexjClgInfoView.super.onExit(self)
end

function DivinexjClgInfoView:_onClickChallenge()
	local isPass = DivineXingJiangClgModel.instance:isPassStage(self._activityId, self._stageId)

	if isPass then
		FloatWordMgr.instance:show("已激活")

		return
	end

	self:close()
	DivineXingJiangClgController.instance:openMissionView(self._activityId, self._stageId)
end

function DivinexjClgInfoView:_onClickSwitch()
	local newStageId = self._cfgSameTeam.stageId

	self._stageId = newStageId

	UIStateManager.instance:updateParms(ViewName.DivinexjClgInfoView, {
		newStageId
	})

	self._cfgStage = self._cfgSameTeam
	self._cfgSameTeam = self._cfgStage
	self._cfgStarAtlas = DivineXingJiangClgConfig.instance:getStarAtlasCfg(self._cfgStage.starAtlasId)

	self:_updateView()
end

function DivinexjClgInfoView:_updateView()
	self:_updateBaseInfo()
	self:_updateFmtInfo()
end

function DivinexjClgInfoView:_updateBaseInfo()
	self._txtName.text = "星座星图-" .. self._cfgStage.name

	self._icon:SetState(self._cfgStage.stageId - 1)

	self._txtDesc1.text = self._cfgStage.buffDesc1[1]
	self._txtTip1.text = self._cfgStage.buffDesc1[2]
	self._txtDesc2.text = self._cfgStage.buffDesc2[1]
	self._txtTip2.text = self._cfgStage.buffDesc2[2]
	self._txtDesc3.text = self._cfgStage.buffDesc3[1]
	self._txtTip3.text = self._cfgStage.buffDesc3[2]

	if self._cfgSameTeam then
		self._txtDesc4.text = self._cfgSameTeam.name or ""
	end
end

function DivinexjClgInfoView:_updateFmtInfo()
	local selfTxt = StringUtil.SubUtf8String(self._cfgStage.name, 1, 1)
	local sameTeamTxt = StringUtil.SubUtf8String(self._cfgSameTeam.name, 1, 1)

	for i, v in ipairs(self._fmtList) do
		if TableUtil.isHad(self._cfgStarAtlas.posIds, i) then
			GameUtil.SetActive(v.go, true)

			local isActiveSelfPos = DivineXingJiangClgModel.instance:isActivePos(self._activityId, self._stageId, i)
			local isActiveSameTeamPos = DivineXingJiangClgModel.instance:isActivePos(self._activityId, self._cfgSameTeam.stageId, i)
			local showNum = 0

			if isActiveSelfPos then
				showNum = showNum + 1
			end

			if isActiveSameTeamPos then
				showNum = showNum + 1
			end

			if showNum == 2 then
				GameUtil.SetActive(v.tagTop, true)
				GameUtil.SetActive(v.tagBottom, true)

				v.txtTop.text = sameTeamTxt
				v.txtBottom.text = selfTxt
			elseif showNum == 1 then
				if isActiveSelfPos then
					GameUtil.SetActive(v.tagTop, false)
					GameUtil.SetActive(v.tagBottom, true)

					v.txtBottom.text = selfTxt
				end

				if isActiveSameTeamPos then
					GameUtil.SetActive(v.tagTop, true)
					GameUtil.SetActive(v.tagBottom, false)

					v.txtTop.text = sameTeamTxt
				end
			else
				GameUtil.SetActive(v.tagTop, false)
				GameUtil.SetActive(v.tagBottom, false)
			end
		else
			GameUtil.SetActive(v.go, false)
		end
	end
end

return DivinexjClgInfoView
