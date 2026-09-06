-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZooanimalinfoView.lua

module("logic.extensions.zoo.view.ZooanimalinfoView", package.seeall)

local ZooanimalinfoView = class("ZooanimalinfoView", ViewComponent)

function ZooanimalinfoView:buildUI()
	ZooanimalinfoView.super.buildUI(self)

	self._closeBtn = self:getBtn("close")
	self._animalIcon = self:getGo("animalIcon")
	self._name = self:getTxt("animalIcon/name")
	self._changeBtn = self:getBtn("animalIcon/changeBtn")
	self._followIcon = self:getGo("animalIcon/followIcon")
	self._showBtn = self:getBtn("showBtn")
	self._shareBtn = self:getBtn("shareBtn")
	self._deleteBtn = self:getBtn("deleteBtn")
	self._level = self:getTxt("level")
	self._surplusTimes = self:getTxt("surplusTimes")
	self._geneCell = self:getGo("item_gene")
	self._normal = self:getGo("normal/genes")
	self._normalView = ScrollerList.create(self._normal, self._geneCell, GameUtil.handler(self._updateGeneCell, self))
	self._special = self:getGo("special/genes")
	self._specialView = ScrollerList.create(self._special, self._geneCell, GameUtil.handler(self._updateGeneCell, self))
	self._followBtn = self:getBtn("followBtn")
	self._followBtnText = self:getTxt("followBtn/Text")
	self._pairBtn = self:getBtn("pairBtn")
	self._gameBtn = self:getBtn("gameBtn")
end

function ZooanimalinfoView:bindEvents()
	ZooanimalinfoView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self._onClickClose, self)
	self._changeBtn:AddClickListener(self._onClickChange, self)
	self._showBtn:AddClickListener(self._onClickShow, self)
	self._shareBtn:AddClickListener(self._onClickShare, self)
	self._deleteBtn:AddClickListener(self._onClickDelete, self)
	self._followBtn:AddClickListener(self._onClickFollow, self)
	self._pairBtn:AddClickListener(self._onClickPair, self)
	self._gameBtn:AddClickListener(self._onClickGame, self)
end

function ZooanimalinfoView:unbindEvents()
	ZooanimalinfoView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._changeBtn:RemoveClickListener()
	self._showBtn:RemoveClickListener()
	self._shareBtn:RemoveClickListener()
	self._deleteBtn:RemoveClickListener()
	self._followBtn:RemoveClickListener()
	self._pairBtn:RemoveClickListener()
	self._gameBtn:RemoveClickListener()
end

function ZooanimalinfoView:onEnter()
	ZooanimalinfoView.super.onEnter(self)

	local openParam = self:getOpenParam()

	self:_initActiveFlags(openParam)
	self:updateView(openParam[1])
	GlobalDispatcher:addListener(GlobalNotify.OnZooChangeAnimalName, self._onZooChangeAnimalName, self)
	GlobalDispatcher:addListener(GlobalNotify.OnZooRecycleAnimal, self._onRecycleAnimal, self)
	GlobalDispatcher:addListener(GlobalNotify.ZooPetFollowStaus, self._updateFollowStatus, self)
end

function ZooanimalinfoView:_initActiveFlags(openParam)
	self._activeFlag = not openParam[2]

	goutil.setActive(self._changeBtn.gameObject, self._activeFlag)
	goutil.setActive(self._followBtn.gameObject, self._activeFlag)
	goutil.setActive(self._deleteBtn.gameObject, self._activeFlag)
	goutil.setActive(self._shareBtn.gameObject, self._activeFlag)
	goutil.setActive(self._pairBtn.gameObject, self._activeFlag)
end

function ZooanimalinfoView:onExit()
	ZooanimalinfoView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.OnZooChangeAnimalName, self._onZooChangeAnimalName, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnZooRecycleAnimal, self.close, self)
	GlobalDispatcher:removeListener(GlobalNotify.ZooPetFollowStaus, self._updateFollowStatus, self)
	self._normalView:dispose()
	self._avatar:destroy()
	self._animalShow:clear()
end

function ZooanimalinfoView:_updateGeneCell(view, cell, data)
	local component = ItemGene.AddOnce(cell.gameObject)

	component:setData(data)
end

function ZooanimalinfoView:_onRecycleAnimal(animalId)
	if animalId == self._animalModel.id then
		self:close()
	end
end

function ZooanimalinfoView:updateView(animalModel)
	self._animalModel = animalModel

	if self._activeFlag then
		self:_updateFollowStatus()
	else
		goutil.setActive(self._followIcon, false)
	end

	self._name.text = self._animalModel.name
	self._level.text = string.format(lang("petzoo_animal_gradeinfo"), self._animalModel.level)
	self._surplusTimes.text = string.format(lang("petzoo_matchtimes_remain"), self._animalModel.restMatchTimes)

	self._animalModel:refreshNormalGeneView(self._normalView)
	self._animalModel:refreshSpecialGeneView(self._specialView)

	self._animalShow, self._avatar = self._animalModel:showAnimalAvatar(self._animalIcon, 256, 256, 0.56, 0.45)

	uGuiUtil.setGoGrayState(self._pairBtn.gameObject, not self._animalModel:isCanMatch())
end

function ZooanimalinfoView:_onZooChangeAnimalName(animalId, status)
	if self._animalModel and status == 0 and animalId == self._animalModel.id then
		self._name.text = self._animalModel.name
	end
end

function ZooanimalinfoView:_onClickClose()
	self:close()
end

function ZooanimalinfoView:_onClickChange()
	UIStateManager.instance:push(ViewName.ZooRenameView, self._animalModel.id)
end

function ZooanimalinfoView:_onClickShow()
	return
end

function ZooanimalinfoView:_onClickShare()
	UIStateManager.instance:push(ViewName.Share, GameEnum.ShareType.Zoo, self._animalModel)
end

function ZooanimalinfoView:_onClickDelete()
	local lvLimit = ZooConfig.instance:getRecycleAnimalNeedLvTime()

	if lvLimit > self._animalModel.level then
		FloatWordMgr.instance:show(string.format(lang("petzoo_animal_delete_lvlimittips"), lvLimit))

		return
	end

	local tipStr = lang("petzoo_animal_cantdelete_tips")

	if self._animalModel.follow then
		FloatWordMgr.instance:show(string.format(tipStr, lang("petzoo_animal_state_follow")))
	elseif self._animalModel.place then
		FloatWordMgr.instance:show(string.format(tipStr, lang("petzoo_animal_state_placed")))
	elseif self._animalModel.working then
		FloatWordMgr.instance:show(string.format(tipStr, lang("petzoo_animal_state_working")))
	else
		UIStateManager.instance:push(ViewName.ZoorecycleView, self._animalModel.id)
	end
end

function ZooanimalinfoView:_onClickFollow()
	ZooController.instance:sendPM_AnimalSetFollowStateReq(self._animalModel.id, not self._animalModel.follow)
end

function ZooanimalinfoView:_updateFollowStatus()
	self._followBtnText.text = self._animalModel.follow and lang("petzoo_animalinfo_dontfollow") or lang("petzoo_animalinfo_follow")

	goutil.setActive(self._followIcon, self._animalModel.follow)
end

function ZooanimalinfoView:_onClickPair()
	if self._animalModel:isCanMatch() then
		self:close()
		UIStateManager.instance:push(ViewName.ZooinvitepairView, self._animalModel)
	elseif self._animalModel:isMatchCD() then
		FloatWordMgr.instance:show(lang("petzoo_matchtimes_cd"))
	else
		FloatWordMgr.instance:show(lang("petzoo_matchtimes_over"))
	end
end

function ZooanimalinfoView:_onClickGame()
	return
end

return ZooanimalinfoView
