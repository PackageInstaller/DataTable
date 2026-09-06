-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownPlayerInfoView.lua

module("logic.extensions.showdown.view.ShowDownPlayerInfoView", package.seeall)

local ShowDownPlayerInfoView = class("ShowDownPlayerInfoView", ViewComponent)

function ShowDownPlayerInfoView:ctor()
	ShowDownPlayerInfoView.super.ctor(self)
end

function ShowDownPlayerInfoView:unbindEvents()
	ShowDownPlayerInfoView.super.unbindEvents(self)
	self._customInput:RemoveListener()
end

function ShowDownPlayerInfoView:bindEvents()
	ShowDownPlayerInfoView.super.bindEvents(self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function ShowDownPlayerInfoView:buildUI()
	ShowDownPlayerInfoView.super.buildUI(self)

	self._box = goutil.findChild(self.mainGO, "box")
	self._adjustPosition = self._box:GetComponent("UIAdjustPosition")
	self._content = self:getGo("content")
	self._enemyList = {}

	for i = 1, 9 do
		self._enemyList[i] = {
			go = goutil.findChild(self._content, "teamEnemy/cell_" .. i),
			con = goutil.findChild(self._content, "teamEnemy/cell_" .. i .. "/icon"),
			select = goutil.findChild(self._content, "teamEnemy/cell_" .. i .. "/select")
		}
	end

	self._txtName = self:getTxt("content/txtName")
	self._txtWin = self:getTxt("content/txtWin")
	self._txtBless = self:getTxt("content/txtBless")
	self._txtBuffEmpty = self:getTxt("content/txtBuffEmpty")
	self._headcell = self:getGo("content/headcell")
	self._customInput = UICustomInput.Get(self:getGo("content"))
end

function ShowDownPlayerInfoView:onExit()
	ShowDownPlayerInfoView.super.onExit(self)

	for i = 1, 9 do
		MaterialMgr.clearIcon(self._enemyList[i].con)
	end

	HeadItemController.instance:resetHeadCell(self._headcell)
end

function ShowDownPlayerInfoView:onEnter()
	ShowDownPlayerInfoView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDownTeam_GetPlayerViewRes, self._refreshView, self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._headInfo = params[2]
	self._playerId = self._headInfo.userId

	ShowDownController.instance:sendPM_ShowDownTeam_GetPlayerViewReq(self._activityId, self._playerId)
end

function ShowDownPlayerInfoView:_refreshView()
	local showDownMo = ShowDownController.instance:getShowDownMo(self._activityId)
	local info = showDownMo:getTempPlayerInfo()

	self._txtName.text = self._headInfo.userName
	self._txtWin.text = langPara("<color=#20b376>%s</color>胜%d负", info.qualifyWinLoseMark.left, info.qualifyWinLoseMark.right)

	local buffCfg = ShowDownConfig.instance:getBuffData(self._activityId, showDownMo:getPlayerRoundId(), info.lastUseForm.buffId)

	self._txtBless.text = buffCfg and buffCfg.desc or ""

	GameUtil.SetActive(self._txtBless.gameObject, buffCfg ~= nil)
	GameUtil.SetActive(self._txtBuffEmpty.gameObject, buffCfg == nil)

	for i = 1, 9 do
		GameUtil.SetActive(self._enemyList[i].go, false)
		MaterialMgr.resetAll(self._enemyList[i].con)
		GameUtil.SetActive(self._enemyList[i].select, false)
	end

	for i, v in ipairs(info.lastUseForm.formation.pos) do
		local creepsData = ShowDownConfig.instance:getSystemPetData(v)

		if creepsData then
			local skinId = checknumber(creepsData.faceId)

			if skinId <= 0 then
				skinId = creepsData.raceId
			end

			MaterialMgr.setIcon(self._enemyList[i].con, MatType.PET_SKIN, skinId, nil, nil)
			GameUtil.SetActive(self._enemyList[i].go, true)
		else
			MaterialMgr.clearIcon(self._enemyList[i].con)
		end
	end

	HeadItemController.instance:setHeadCellByInfo(self._headcell, self._headInfo, true)
end

function ShowDownPlayerInfoView:_onCustomInputCallback(hover)
	if not hover then
		self:close()
	end
end

return ShowDownPlayerInfoView
