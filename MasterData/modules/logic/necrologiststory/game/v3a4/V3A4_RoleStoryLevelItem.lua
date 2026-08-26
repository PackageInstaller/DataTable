-- chunkname: @modules/logic/necrologiststory/game/v3a4/V3A4_RoleStoryLevelItem.lua

module("modules.logic.necrologiststory.game.v3a4.V3A4_RoleStoryLevelItem", package.seeall)

local V3A4_RoleStoryLevelItem = class("V3A4_RoleStoryLevelItem", LuaCompBase)

function V3A4_RoleStoryLevelItem:init(go)
	self.go = go
	self.transform = go.transform

	recthelper.setAnchor(self.transform, 0, 0)

	self.txtIndex = gohelper.findChildTextMesh(self.go, "index/#txt_index")
	self.txtName = gohelper.findChildTextMesh(self.go, "#txt_name")
	self.btnClick = gohelper.findChildButtonWithAudio(self.go, "click")
	self.goCurrent = gohelper.findChild(self.go, "#go_current")
	self.anim = self.go:GetComponent(typeof(UnityEngine.Animator))
	self.goNormal = gohelper.findChild(self.go, "namebg/normal")
	self.goSpecial = gohelper.findChild(self.go, "namebg/special")
	self.goGame = gohelper.findChild(self.go, "#go_game")
	self.goFencha = gohelper.findChild(self.go, "go_fencha")
end

function V3A4_RoleStoryLevelItem:addEventListeners()
	self.addClickCb(self, self.btnClick, self.onClickBtn, self)
end

function V3A4_RoleStoryLevelItem:removeEventListeners()
	self:removeClickCb(self.btnClick)
end

function V3A4_RoleStoryLevelItem:onClickBtn()
	if not self.baseConfig then
		return
	end

	local isUnlock = self.gameMO:isBaseUnlock(self.baseConfig.id)

	if not isUnlock then
		return
	end

	local storyId = self.baseConfig.storyId

	if storyId > 0 then
		if self.gameMO:isStoryFinish(storyId) then
			NecrologistStoryController.instance:openStoryView(storyId, nil, self._onStoryClose, self)
		else
			NecrologistStoryController.instance:openStoryView(storyId, self.gameMO.id, self._onStoryClose, self)
		end

		return
	end

	if self.baseConfig.gameId > 0 then
		ViewMgr.instance:openView(ViewName.V3A4_RoleStoryGameView, {
			gameId = self.baseConfig.gameId,
			baseId = self.baseConfig.id
		})
	end
end

function V3A4_RoleStoryLevelItem:_onStoryClose()
	if not self.baseConfig or not self.gameMO then
		return
	end

	if self.gameMO:isStoryFinish(self.baseConfig.storyId) then
		self.gameMO:setBaseFinish(self.baseConfig.id)
	end
end

function V3A4_RoleStoryLevelItem:setData(baseConfig, gameMO)
	self.baseConfig = baseConfig
	self.gameMO = gameMO

	self:refreshView()
end

function V3A4_RoleStoryLevelItem:refreshView()
	self.txtIndex.text = self.index
	self.txtName.text = self.baseConfig.name

	local isGame = self.baseConfig.gameId > 0

	gohelper.setActive(self.goGame, isGame)
	gohelper.setActive(self.goNormal, not isGame)
	gohelper.setActive(self.goSpecial, isGame)

	local isUnlock = self.gameMO:isBaseUnlock(self.baseConfig.id)

	if isUnlock and not isGame then
		local storyConfig = NecrologistStoryConfig.instance:getPlotGroupCo(self.baseConfig.storyId)

		gohelper.setActive(self.goFencha, storyConfig.branch == 1)
	else
		gohelper.setActive(self.goFencha, false)
	end

	if isUnlock then
		local isFinish = self.gameMO:isBaseFinish(self.baseConfig.id)

		gohelper.setActive(self.goCurrent, not isFinish)

		if self.isUnlock == false then
			AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_gt_yishi_level)
			self.anim:Play("unlock_ing", 0, 0)
		else
			self.anim:Play("unlock")
		end
	else
		self.anim:Play("lock")
	end

	self.isUnlock = isUnlock
end

function V3A4_RoleStoryLevelItem:onDestroy()
	return
end

return V3A4_RoleStoryLevelItem
