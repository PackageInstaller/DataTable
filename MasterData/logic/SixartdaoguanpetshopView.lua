-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sixartdaoguan/view/SixartdaoguanpetshopView.lua

module("logic.extensions.sixartdaoguan.view.SixartdaoguanpetshopView", package.seeall)

local SixartdaoguanpetshopView = class("SixartdaoguanpetshopView", ViewComponent)

function SixartdaoguanpetshopView:ctor()
	SixartdaoguanpetshopView.super.ctor(self)
end

function SixartdaoguanpetshopView:unbindEvents()
	SixartdaoguanpetshopView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function SixartdaoguanpetshopView:bindEvents()
	SixartdaoguanpetshopView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
end

function SixartdaoguanpetshopView:buildUI()
	SixartdaoguanpetshopView.super.buildUI(self)

	self._roleconGo = self:getGo("rolecon")
	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtbubble = self:getTxt("bubble/txtbubble")
	self._goldconGo = self:getGo("goldcon")
end

function SixartdaoguanpetshopView:onExit()
	SixartdaoguanpetshopView.super.onExit(self)
	self._scrollerList:dispose()

	self._roleObj = RoleObjectPool.instance:removeRole(self._roleObj)
end

function SixartdaoguanpetshopView:onEnter()
	SixartdaoguanpetshopView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.SixArtDaoguanGetInfoRes, self._updateUI, self)
	self.addGEvent(self, GlobalNotify.SixArtDaoguanBuyRentPetRes, self._updateUI, self)

	self._activityId = self:getFirstParam()

	self:_updateUI()
	self:_setRole()
	self:_setBubble()
	self:_setGlodBar()
end

function SixartdaoguanpetshopView:_onClickbtnClose()
	self:close()
end

function SixartdaoguanpetshopView:_onClickbtnTip()
	TipsFacade.instance:openRulesView("sixartdaoguan")
end

function SixartdaoguanpetshopView:_updateUI()
	self:_updatePets()
end

function SixartdaoguanpetshopView:_updatePets()
	local info = SixartdaoguanModel.instance:getInfo(self._activityId)

	if not info then
		return
	end

	local petCfgs = SixartdaoguanConfig.instance:getRentPetCfgs(self._activityId)
	local list = table.values(petCfgs)

	table.sort(list, function(a, b)
		return a.creepsId < b.creepsId
	end)

	if not info.rentPetId then
		local rentPetId_Kv = {}

		for i, petId in ipairs(info.rentPetId) do
			rentPetId_Kv[petId] = petId
		end

		local list_canbuy = {}
		local list_buy = {}
		local list_normal = {}

		for i, v in ipairs(list) do
			if checknumber(v.summonMasterId) <= 0 then
				if rentPetId_Kv[v.creepsId] then
					table.insert(list_buy, v)
				elseif MaterialFacade.instance:isMatsEnough(v.cost) then
					table.insert(list_canbuy, v)
				else
					table.insert(list_normal, v)
				end
			end
		end

		table.insertto(list_canbuy, list_normal)
		table.insertto(list_canbuy, list_buy)
		self._scrollerList:reloadData(list_canbuy)
	end
end

function SixartdaoguanpetshopView:_updateCell(view, cell, data, tag)
	local btnTips = goutil.findChild(cell.gameObject, "btnTips")
	local btnBuy = goutil.findChild(cell.gameObject, "btnBuy")
	local mainGo = goutil.findChild(cell.gameObject, "root")
	local con = goutil.findChild(mainGo, "mask/con")
	local txtCost = goutil.findChildTextComponent(cell, "cost/txtCost")
	local costIcon = goutil.findChild(cell, "cost/icon")
	local goCost = goutil.findChild(cell, "cost")
	local goTxtHadBuyTips = goutil.findChild(cell, "txtHadBuyTips")
	local qiyueGo = goutil.findChild(cell, "qiyue")
	local qiyueItemGo = goutil.findChild(cell, "qiyue/item")
	local lockGo = goutil.findChild(cell, "lock")
	local txtLock = goutil.findChildTextComponent(cell, "lock/txtLock")
	local txtLvl = goutil.findChildTextComponent(cell, "txtLvl")
	local Nego_Attr = goutil.findChild(cell, "layout/Nego_Attr")
	local Img_attr = goutil.findChild(cell, "layout/Nego_Attr/Img_attr")
	local Nego_Job = goutil.findChild(cell, "layout/Nego_Job")
	local ImgC_Job = goutil.findChild(cell, "layout/Nego_Job/ImgC_Job")
	local Nego_Job1 = goutil.findChild(cell, "layout/Nego_Job1")
	local ImgC_Job_1 = goutil.findChild(cell, "layout/Nego_Job1/ImgC_Job")
	local summonedPetId = checknumber(data.summonedPetId)
	local hasSummoned = summonedPetId > 0
	local skinId = data.raceId
	local isLock = GameUtil.string2time(data.openDateTime) > ServerTime.now()

	goutil.setActive(qiyueGo, hasSummoned)
	goutil.setActive(lockGo, isLock)

	if isLock then
		local date = GameUtil.string2date(data.openDateTime)

		txtLock.text = string.format("%s.%s开放招募", date.month, date.day)
	end

	if hasSummoned then
		local rentCfg = SixartdaoguanConfig.instance:getRentPetCfg(self._activityId, summonedPetId)
		local proxy = MaterialMgr.setCell(MatType.Pet, rentCfg.raceId, qiyueItemGo)

		if proxy then
			proxy.binder:setAutoTips(false)
			proxy.binder:setCallBack(function()
				local rentMo = SixartdaoguanModel.instance:getRentPetMo(self._activityId, summonedPetId)

				if rentMo then
					CommonTipsMgr.instance:showPetTips(rentMo)
				end
			end)
		end
	end

	local modelCo = CharacterConfig.instance:getModelCo(checknumber(skinId))

	if modelCo and not string.nilorempty(modelCo.cardName) then
		local imgUrl = GameUrl.getPetImgUrl(modelCo.cardName)

		uGuiUtil.setSpriteToImage(con, uGuiUtil.SpriteType.BigBg, imgUrl)
	end

	txtLvl.text = data.lv

	local matType, matId, matNum = MaterialMgr.getMatParams(data.cost)

	txtCost.text = matNum

	MaterialMgr.setIcon(costIcon, matType, matId)

	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(skinId)

	race = race % 10

	GameUtil.setUIImageSpriteIdx(Img_attr, race - 1)

	local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(skinId)

	GameUtil.setUIImageSpriteIdx(ImgC_Job, firstJobIdx - 1)

	local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx(skinId)
	local isNeedJob1 = secondJobIdx > 20

	GameUtil.SetActive(Nego_Job1, isNeedJob1)

	if isNeedJob1 then
		GameUtil.setUIImageSpriteIdx(ImgC_Job_1, secondJobIdx - 1 - 20)
	end

	local info = SixartdaoguanModel.instance:getInfo(self._activityId)
	local hadBuy = not not (info and info.rentPetId and table.indexof(info.rentPetId, data.creepsId))

	goutil.setActive(goCost, not hadBuy)
	goutil.setActive(goTxtHadBuyTips, hadBuy)
	GameUtil.addClickHandler(btnTips, GameUtil.handler(self._onClickBtnTips, self, data.creepsId))
	GameUtil.addClickHandler(btnBuy, GameUtil.handler(self._onClickBtnBuy, self, data.creepsId, isLock, txtLock.text))
end

function SixartdaoguanpetshopView:_clearCell(cell)
	local btnTips = goutil.findChild(cell.gameObject, "btnTips")
	local btnBuy = goutil.findChild(cell.gameObject, "btnBuy")
	local mainGo = goutil.findChild(cell.gameObject, "root")
	local con = goutil.findChild(mainGo, "mask/con")
	local costIcon = goutil.findChild(cell, "cost/icon")
	local qiyueItemGo = goutil.findChild(cell, "qiyue/item")

	uGuiUtil.clearImage(con)
	MaterialMgr.resetAll(costIcon)
	GameUtil.addClickHandler(btnTips)
	GameUtil.addClickHandler(btnBuy)
	MaterialMgr.resetAll(qiyueItemGo)
end

function SixartdaoguanpetshopView:_onClickBtnTips(creepsId)
	local rentMo = SixartdaoguanModel.instance:getRentPetMo(self._activityId, creepsId)

	if rentMo then
		CommonTipsMgr.instance:showPetTips(rentMo)
	end
end

function SixartdaoguanpetshopView:_onClickBtnBuy(creepsId, isLock, tips)
	if isLock then
		FloatWordMgr.instance:show(tips)

		return
	end

	local info = SixartdaoguanModel.instance:getInfo(self._activityId)

	if not info then
		return
	end

	if info.rentPetId and table.indexof(info.rentPetId, creepsId) then
		FloatWordMgr.instance:show("已招募该精灵")

		return
	end

	local rentCfg = SixartdaoguanConfig.instance:getRentPetCfg(self._activityId, creepsId)
	local matType, matId, matNum = MaterialMgr.getMatParams(rentCfg.cost)
	local matName = MaterialMgr.getMaterialsName(matType, matId)
	local content = string.format("是否消耗%s%s购买%s？", matNum, matName, rentCfg.creepsName)

	local function successCallBack()
		SixArtDaoguanAgent.instance:sendPM_SixArtDaoguanBuyRentPetReq(self._activityId, rentCfg.creepsId)
	end

	TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, content, successCallBack)
end

function SixartdaoguanpetshopView:_setRole()
	local x, y, scale = 0, 0, 1
	local raceId = SixartdaoguanConfig.instance:getClientValue("PetShopRaceId", true)

	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, raceId, self._roleconGo, scale, nil, true, x, y)
end

function SixartdaoguanpetshopView:_setBubble()
	self._txtbubble.text = SixartdaoguanConfig.instance:getClientValue("PetShopBubble")
end

function SixartdaoguanpetshopView:_setGlodBar()
	local btn_list = {}
	local str = SixartdaoguanConfig.instance:getClientValue("PetShopCoin")
	local list = string.split(str, "#")

	for i, v in ipairs(list) do
		table.insert(btn_list, {
			showAdd = true,
			id = v
		})
	end

	MainUIController.instance:showGlodBar(self._goldconGo, self._viewPresentor, btn_list, false)
end

return SixartdaoguanpetshopView
