-- chunkname: @modules/logic/autochess/main/view/game/AutoChessWarnUpView.lua

module("modules.logic.autochess.main.view.game.AutoChessWarnUpView", package.seeall)

local AutoChessWarnUpView = class("AutoChessWarnUpView", BaseView)

function AutoChessWarnUpView:onInitView()
	self._btnNext = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Next")
	self._goRight = gohelper.findChild(self.viewGO, "#go_Right")
	self._goCollection = gohelper.findChild(self.viewGO, "#go_Right/#go_Collection")
	self._goCollectionContent = gohelper.findChild(self.viewGO, "#go_Right/#go_Collection/Viewport/#go_CollectionContent")
	self._goItem = gohelper.findChild(self.viewGO, "#go_Right/#go_Collection/Viewport/#go_CollectionContent/#go_Item")
	self._goCardpack = gohelper.findChild(self.viewGO, "#go_Right/#go_Cardpack")
	self._goCardpackContent = gohelper.findChild(self.viewGO, "#go_Right/#go_Cardpack/Viewport/#go_CardpackContent")
	self._goBoss = gohelper.findChild(self.viewGO, "#go_Right/#go_Boss")
	self._goBMesh = gohelper.findChild(self.viewGO, "#go_Right/#go_Boss/#go_BMesh")
	self._txtBName = gohelper.findChildText(self.viewGO, "#go_Right/#go_Boss/#txt_BName")
	self._txtBDesc = gohelper.findChildText(self.viewGO, "#go_Right/#go_Boss/scroll_des/viewport/content/#txt_BDesc")
	self._goLeft = gohelper.findChild(self.viewGO, "#go_Left")
	self._goWarnContent = gohelper.findChild(self.viewGO, "#go_Left/#go_WarnContent")
	self._goStage = gohelper.findChild(self.viewGO, "#go_Left/#go_Stage")
	self._txtStage = gohelper.findChildText(self.viewGO, "#go_Left/#go_Stage/#txt_Stage")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AutoChessWarnUpView:addEvents()
	self._btnNext:AddClickListener(self._btnNextOnClick, self)
end

function AutoChessWarnUpView:removeEvents()
	self._btnNext:RemoveClickListener()
end

function AutoChessWarnUpView:_btnNextOnClick()
	self.index = self.index + 1

	if self.index == 2 then
		if self.collectionIds or self.spMasterId ~= 0 then
			self.anim:Play("right", 0, 0)

			self.hasPlay = true

			self:refreshUI()
		else
			self:_btnNextOnClick()
		end
	elseif self.index == 3 then
		if self.cardpackIds then
			if not self.hasPlay then
				self.anim:Play("right", 0, 0)

				self.hasPlay = true
			end

			self:refreshUI()
		else
			self:_btnNextOnClick()
		end
	elseif self.index == 4 then
		if self.bossId then
			if not self.hasPlay then
				self.anim:Play("right", 0, 0)

				self.hasPlay = true
			end

			self:refreshUI()
		else
			self:_btnNextOnClick()
		end
	else
		self:closeThis()
	end
end

function AutoChessWarnUpView:_editableInitView()
	self.anim = self.viewGO:GetComponent(gohelper.Type_Animator)

	local go = self:getResInst(AutoChessStrEnum.ResPath.WarningItem, self._goWarnContent)

	MonoHelper.addNoUpdateLuaComOnceToGo(go, AutoChessWarningItem):refreshUI()

	self.actMo = Activity182Model.instance:getActMo()
	self.levelCfg = lua_auto_chess_level.configDict[self.actMo.activityId][self.actMo.warnLevel]

	if not string.nilorempty(self.levelCfg.unlockCollectionIds) then
		self.collectionIds = string.splitToNumber(self.levelCfg.unlockCollectionIds, "#")
	end

	self.spMasterId = self.levelCfg.spMasterId

	if not string.nilorempty(self.levelCfg.unlockCardpackIds) then
		self.cardpackIds = string.splitToNumber(self.levelCfg.unlockCardpackIds, "#")
	end

	if not string.nilorempty(self.levelCfg.unlockBossIds) then
		self.bossId = string.splitToNumber(self.levelCfg.unlockBossIds, "#")[1]
	end
end

function AutoChessWarnUpView:onOpen()
	self.index = 1
end

function AutoChessWarnUpView:onClose()
	self.actMo:clearWarnLevelUpMark()
	AutoChessController.instance:checkPopView()
end

function AutoChessWarnUpView:refreshUI()
	if not self.refreshed then
		gohelper.setActive(self._goStage, true)
		gohelper.setActive(self._goRight, true)
		recthelper.setAnchor(self._goLeft.transform, -463, -9)

		self.refreshed = true
	end

	self._txtStage.text = luaLang("autochess_warnupview_stage" .. self.index - 1)

	gohelper.setActive(self._goCollection, self.index == 2)
	gohelper.setActive(self._goCardpack, self.index == 3)
	gohelper.setActive(self._goBoss, self.index == 4)

	if self.index == 2 then
		if self.collectionIds then
			for _, id in ipairs(self.collectionIds) do
				local parent = gohelper.cloneInPlace(self._goItem)
				local collectionGo = self:getResInst(AutoChessStrEnum.ResPath.CollectionItem, parent)
				local item = MonoHelper.addNoUpdateLuaComOnceToGo(collectionGo, AutoChessCollectionItem)

				item:setData(id)
			end
		end

		if self.spMasterId ~= 0 then
			local parent = gohelper.cloneInPlace(self._goItem)
			local leaderGo = self:getResInst(AutoChessStrEnum.ResPath.LeaderCard, parent)
			local item = MonoHelper.addNoUpdateLuaComOnceToGo(leaderGo, AutoChessLeaderCard)

			item:setData({
				leaderId = self.spMasterId
			})
		end

		gohelper.setActive(self._goItem, false)
	elseif self.index == 3 then
		self.cardpackCfgs = {}

		for k, id in ipairs(self.cardpackIds) do
			self.cardpackCfgs[k] = AutoChessConfig.instance:getCardpackCfg(id)

			local go = self:getResInst(AutoChessStrEnum.ResPath.CardPackItem, self._goCardpackContent)
			local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, AutoChessCardpackItem)

			item:setData(self.cardpackCfgs[k])
			item:setCheckCallback(self._checkCardpack, self)
			transformhelper.setLocalScale(item.go.transform, 0.7, 0.7, 1)
		end
	elseif self.index == 4 then
		local chesCfg = AutoChessConfig.instance:getChessCfg(self.bossId)
		local meshComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._goBMesh, AutoChessMeshComp)

		meshComp:setData(chesCfg.image, true)

		self._txtBName.text = chesCfg.name
		self._txtBDesc.text = chesCfg.skillDesc
	end
end

function AutoChessWarnUpView:_checkCardpack(cardpackId)
	local checkIndex

	for k, config in ipairs(self.cardpackCfgs) do
		if config.id == cardpackId then
			checkIndex = k

			break
		end
	end

	local param = {
		index = checkIndex,
		configs = self.cardpackCfgs
	}

	ViewMgr.instance:openView(ViewName.AutoChessCardpackInfoView, param)
end

return AutoChessWarnUpView
