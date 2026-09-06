-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZooOtherAnimalInfoView.lua

module("logic.extensions.zoo.view.ZooOtherAnimalInfoView", package.seeall)

local ZooOtherAnimalInfoView = class("ZooOtherAnimalInfoView", ViewComponent)

function ZooOtherAnimalInfoView:buildUI()
	ZooOtherAnimalInfoView.super.buildUI(self)

	self._name = self:getTxt("name/Text")
	self._pairTimes = self:getTxt("pairTimes/value")
	self._geneCell = self:getGo("item_gene")
	self._normal = self:getGo("normal/genes")
	self._normalView = ScrollerList.create(self._normal, self._geneCell, GameUtil.handler(self._updateGeneCell, self))
	self._special = self:getGo("special/genes")
	self._specialView = ScrollerList.create(self._special, self._geneCell, GameUtil.handler(self._updateGeneCell, self))
	self._closeBtn = self:getBtn("close")
	self._addFriendBtn = self:getBtn("addFriendBtn")
	self._goSeeBtn = self:getBtn("goSeeBtn")
	self._animal = self:getGo("animal")
end

function ZooOtherAnimalInfoView:bindEvents()
	ZooOtherAnimalInfoView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._addFriendBtn:AddClickListener(self._onClickAddFriend, self)
	self._goSeeBtn:AddClickListener(self._onClickGoSee, self)
end

function ZooOtherAnimalInfoView:unbindEvents()
	ZooOtherAnimalInfoView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._addFriendBtn:RemoveClickListener()
	self._goSeeBtn:RemoveClickListener()
end

function ZooOtherAnimalInfoView:onEnter()
	ZooOtherAnimalInfoView.super.onEnter(self)

	local openParam = self:getOpenParam()
	local animalMo = openParam[1]

	self._friendId = openParam[2]
	self._name.text = animalMo.name
	self._pairTimes.text = string.format(lang("petzoo_matchtimes_num"), animalMo.restMatchTimes)

	animalMo:refreshNormalGeneView(self._normalView)
	animalMo:refreshSpecialGeneView(self._specialView)

	self._animalShow, self._avatar = animalMo:showAnimalAvatar(self._animal, 300, 350, 0.56, 0.45)

	local friendMo = FriendModel.instance:getFriendMo(self._friendId)

	goutil.setActive(self._addFriendBtn.gameObject, not friendMo and self._friendId ~= RoleModel.instance:getUserId())
	goutil.setActive(self._goSeeBtn.gameObject, friendMo)
	uGuiUtil.setGoGrayState(self._goSeeBtn.gameObject, not FuncOpenModel.instance:getFuncIsOpen(110))
end

function ZooOtherAnimalInfoView:onExit()
	ZooOtherAnimalInfoView.super.onExit(self)
	self._animalShow:clear()
	self._avatar:destroy()
end

function ZooOtherAnimalInfoView:onExitFinished()
	ZooOtherAnimalInfoView.super.onExitFinished(self)
end

function ZooOtherAnimalInfoView:_updateGeneCell(view, cell, data)
	local component = ItemGene.AddOnce(cell.gameObject)

	component:setData(data)
end

function ZooOtherAnimalInfoView:_onClickGoSee()
	if FuncOpenModel.instance:getFuncIsOpen(110) then
		ZooSceneController.instance:enterFriendZoo(self._friendId)
		self:close()
	else
		local cfg = FuncOpenConfig.instance:getFunctionOpenById(110)

		FuncOpenController.instance:showLockTips(cfg)
	end
end

function ZooOtherAnimalInfoView:_onClickAddFriend()
	FriendController.instance:addFriend(self._friendId)
end

return ZooOtherAnimalInfoView
