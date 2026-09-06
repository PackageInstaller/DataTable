-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/payshop/view/PayshoppetdetailView.lua

module("logic.extensions.payshop.view.PayshoppetdetailView", package.seeall)

local PayshoppetdetailView = class("PayshoppetdetailView", TableViewComponent)
local json = require("cjson")

function PayshoppetdetailView:ctor()
	PayshoppetdetailView.super.ctor(self)
end

function PayshoppetdetailView:unbindEvents()
	PayshoppetdetailView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
	self._btnJumpTo:RemoveClickListener()
	self._btnSellOut:RemoveClickListener()
end

function PayshoppetdetailView:bindEvents()
	PayshoppetdetailView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnSkill:AddClickListener(self._onClickbtnSkill, self)
	self._btnJumpTo:AddClickListener(self._onClickbtnJumpTo, self)
	self._btnSellOut:AddClickListener(self._onClickBtnSellOut, self)
end

function PayshoppetdetailView:buildUI()
	PayshoppetdetailView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._roleconGo = self:getGo("rolecon")
	self._avatarRoot = self:getGo("bgCam/avatarRoot/avatar")
	self._bgCamTr = self:getGo("bgCam").transform
	self._scrollList = {}
	self._mountRootGo = self:getGo("mountRoot")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")
	self._petSkinInfoGo = self:getGo("petSkinInfo")
	self._petbgGo = self:getGo("petbg")
	self._btnSkill = self:getBtn("petSkinInfo/btnSkill")
	self._txtSkillDesc = goutil.findChildTextComponent(self.mainGO, "petSkinInfo/skillDesc/txtDesc")
	self._bgGo = self:getGo("bgCam/bg")
	self._goldBarConGo = self:getGo("goldBarCon")
	self._txtDiscountTip = goutil.findChildTextComponent(self.mainGO, "txtDiscountTip")
	self._txtDiscountTip.text = ""
	self._discountRootGo = self:getGo("discountRoot")
	self._discountPart = GameUtil.AddLuaOnce(self._discountRootGo, PayshoppetailviewDiscountPart)
	self._btnJumpTo = self:getBtn("btnJumpTo")
	self._txBtnJumpTo = self:getTxt("btnJumpTo/txBtnJumpTo")
	self._btnSellOut = self:getBtn("sellOut")
	self._txtSlogan = goutil.findChildTextComponent(self.mainGO, "petSkinInfo/txtSloganBg/txtSlogan")
	self._txtSloganBg = self:getGo("petSkinInfo/txtSloganBg")
	self._rare = self:getGo("petSkinInfo/rare")
end

function PayshoppetdetailView:onExit()
	PayshoppetdetailView.super.onExit(self)
	GlobalModel.instance:visibleSceneHUDs(true)
	RoleObjectPool.instance:removeRole(self._roleObj)
	self._bgCamTr:SetParent(self.mainGO.transform)

	self._rankId = nil
	self._skinId = nil

	if self._avatar then
		self._avatar:removeListener(AvatarNotify.OnMountLoaded, self._onMountLoaded, self)
		AvatarsMgrNew.instance:removeAvatar(self._avatar)

		self._avatar = nil
		self.avatarMo = nil
	end

	if self._mountPart then
		self._mountPart:onExit()
	end

	uGuiUtil.clearImage(self._bgGo)
	GlobalDispatcher:removeListener(PayShopController.NotifyPayShopItemBuySucRes, self._NotifyPayShopItemBuySucRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.PayShopSelectMountId, self._payShopSelectMountId, self)
	self._discountPart:onExit()
	MaterialMgr.resetAll(self._rare)
end

function PayshoppetdetailView:onEnter()
	PayshoppetdetailView.super.onEnter(self)
	GlobalModel.instance:visibleSceneHUDs(false)
	GlobalDispatcher:addListener(PayShopController.NotifyPayShopItemBuySucRes, self._NotifyPayShopItemBuySucRes, self)
	GlobalDispatcher:addListener(GlobalNotify.PayShopSelectMountId, self._payShopSelectMountId, self)
	self._bgCamTr:SetParent(nil)

	local params = self:getOpenParam()

	self._sellKey = params[1]
	self._goodsDefineId = checknumber(params[2])
	self._discountPlanId = checknumber(params[3])
	self._showLeftTime = checkbool(params[4])
	self._isAutoJumpMibao = checkbool(params[5])

	self:_setDefaultValueIfIsSellMulMount()
	self:_updateView()
end

function PayshoppetdetailView:_updateView()
	self._goodsCfg = PayShopConfig.instance:getPayShopGoodsCfgById(self._goodsDefineId)

	goutil.setActive(self._petbgGo, self:_isSellPet() or self:_isSellPetSkin())
	goutil.setActive(self._petSkinInfoGo, self:_isSellPetSkin())
	goutil.setActive(self._mountRootGo, self:_isSellMount())
	goutil.setActive(self._tableview.gameObject, true)

	if self:_isSellMount() then
		self._mountPart = GameUtil.AddLuaOnce(self._mountRootGo, PayshoppetdetailMountAttrPart)
	end

	self:_setDiscountTip("")
	self:_setTitle()
	self:_setBgImg()
	self:_loadData()
	self:_setGoldBar()
	self._discountPart:setRootActive(true)
	self._discountPart:onEnter(self._goodsDefineId, self._discountPlanId)
	goutil.setActive(self._btnJumpTo.gameObject, self:_isJumpGoods())

	if self:_isJumpGoods() then
		self._txBtnJumpTo.text = self._goodsCfg.jumpToDesc
	end

	self:_checkSellOut()
end

function PayshoppetdetailView:_loadData()
	self._mountActiveItems = {}
	self._curViewDatas = {
		self._goodsCfg
	}

	if self:_isSellMount() then
		self:_loadMountActiveData()
	end

	self._rankId = self._goodsCfg.id

	self:_setDiscountTip(self._goodsCfg.discountDesc)
	self:reloadData()
end

function PayshoppetdetailView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function PayshoppetdetailView:_updateCell(view, cell, data)
	local btnBuy = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btns/btnBuy")
	local goIcon = goutil.findChild(cell.gameObject, "icon")
	local goBg = goutil.findChild(cell.gameObject, "bg")
	local btnSelect = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnSelect")
	local selectGo = goutil.findChild(cell.gameObject, "select")
	local txtBtnBuy = goutil.findChildTextComponent(cell.gameObject, "btns/btnBuy/txtBtnBuy")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local goTablecell = goutil.findChild(cell.gameObject, "tablecell")
	local goTableview = goutil.findChild(cell.gameObject, "tableview")
	local payIcon = goutil.findChild(cell.gameObject, "btns/btnBuy/payIcon")
	local payIconChange = payIcon:GetComponent(ComponentType.UIImageSpriteChange)
	local goodsCfg = data

	uGuiUtil.setSpriteToImage(goIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(goodsCfg.icon))

	local payGoodsId = goodsCfg.originalGoodsId

	if PayShopModel.instance:checkCanDisCount(data.id) then
		payGoodsId = PayShopModel.instance:getBuyItemMinCostPayGoodsId(data.id)
	end

	if goodsCfg.payType == GameEnum.PayShopPayType.RMB then
		payIconChange:SetState(1)

		txtBtnBuy.text = PayConfig.instance:getPayMoneyYuan(payGoodsId)
	else
		payIconChange:SetState(0)

		local arr = string.split(payGoodsId, ":")

		MaterialMgr.setIcon(payIcon, checkint(arr[1]), checkint(arr[2]))

		txtBtnBuy.text = arr[#arr]
	end

	local scrollList = self._scrollList[goTableview]

	if not scrollList then
		scrollList = ScrollerList.create(goTableview, goTablecell, GameUtil.handler(self._updateSubCell, self), GameUtil.handler(self._clearSubCell, self))
		self._scrollList[goTableview] = scrollList
	end

	local list = string.split(goodsCfg.content, "#")

	scrollList:reloadData(list)

	txtName.text = goodsCfg.name

	local isSelect = true

	goutil.setActive(selectGo, isSelect)

	if isSelect then
		self:_showRole(list)
	end

	btnBuy:AddClickListener(function()
		local obj = {
			id = data.id,
			times = PayShopModel.instance:getMibaoBuyTimesById(data.id)
		}

		UIStateManager.instance:push(ViewName.PayShopMibaoBuyView, obj, self._showLeftTime)
	end)
	btnSelect:AddClickListener(function()
		if self._rankId == data.id then
			return
		end

		self._rankId = data.id

		self:reloadData()
		self:_setDiscountTip(data.discountDesc)
	end)
end

function PayshoppetdetailView:_clearTableview(cell)
	local goIcon = goutil.findChild(cell.gameObject, "icon")
	local goTableview = goutil.findChild(cell.gameObject, "tableview")
	local payIcon = goutil.findChild(cell.gameObject, "btns/btnBuy/payIcon")

	MaterialMgr.resetAll(payIcon)

	if self._scrollList[goTableview] then
		self._scrollList[goTableview]:dispose()
	end

	uGuiUtil.clearImage(goIcon)
end

function PayshoppetdetailView:_updateSubCell(view, cell, cfgStr)
	MaterialMgr.setCellByCfg(cfgStr, cell.gameObject)
end

function PayshoppetdetailView:_clearSubCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function PayshoppetdetailView:_onClickbtnClose()
	if self._isSellMulMount then
		self:close()

		return
	end

	if self._isAutoJumpMibao then
		local jumpTo = GameEnum.PayShopTabSellTypeJumpTo[self._sellKey]
		local key = PayShopModel.instance:getJumpInTag()

		if key then
			jumpTo = string.format("mibao#%s", key)
		end

		local jumpTabtypes = PayShopModel.instance:getJumpPageParam()

		if jumpTabtypes then
			jumpTo = jumpTo .. "#" .. ((type(jumpTabtypes) == "table" or nil) and json.encode(jumpTabtypes))
		end

		GotoMgr.gotoByString(jumpTo)
	end

	self:close()
end

function PayshoppetdetailView:_showRole(matList)
	if self:_isSellPet() then
		local petStr

		for i, str in ipairs(matList) do
			if string.find(str, "^" .. MatType.Pet .. ":") then
				petStr = str

				break
			end
		end

		if petStr then
			local arr = string.split(petStr, ":")
			local raceId = checknumber(arr[2])

			self:_showPet(raceId)
		end
	elseif self:_isSellPetSkin() then
		local skinStr

		for i, str in ipairs(matList) do
			if string.find(str, "^" .. MatType.PET_SKIN .. ":") then
				skinStr = str

				break
			end
		end

		if skinStr then
			local arr = string.split(skinStr, ":")
			local skinId = checknumber(arr[2])

			self:_showPetSkin(skinId)
		end
	elseif self:_isSellMount() then
		if self._secondSelectMountId then
			self:_showMount(self._secondSelectMountId)

			self._secondSelectMountId = nil
		else
			local mountId = 0

			for i, str in ipairs(matList) do
				if self._mountActiveItems[str] then
					mountId = self._mountActiveItems[str].mountId

					break
				end
			end

			self:_showMount(mountId)
		end
	end
end

function PayshoppetdetailView:_showPet(raceId)
	raceId = checknumber(raceId)

	local displayBagOffset = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(raceId)
	local x, y, scale = 0, 0, 1

	if displayBagOffset then
		x = checknumber(displayBagOffset[1])
		y = checknumber(displayBagOffset[2])
		scale = displayBagOffset[3] or 1
	end

	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, raceId, self._roleconGo, scale, nil, true, x, y)
end

function PayshoppetdetailView:_showPetSkin(skinId)
	self._skinId = skinId

	self:_showPet(skinId)

	local skinCfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

	self._txtSkillDesc.text = skinCfg.desc
	self._txtSlogan.text = skinCfg.skinName

	MaterialMgr.setCell(MatType.PetSkin_Rare, skinId, self._rare)
end

function PayshoppetdetailView:_showMount(mountId)
	mountId = checknumber(mountId)

	if mountId <= 0 then
		return
	end

	self._selectMountId = mountId

	if not self._avatar then
		self._avatar = AvatarsMgrNew.instance:getAvatarByType(AvatarCreateType.Player)

		self._avatar:setParent(self._avatarRoot.transform)
		self._avatar:setLayer(SceneLayer.UI3D_Value)
		self._avatar:setOwnerUserId(RoleModel.instance:getUserId())
		self._avatar:addListener(AvatarNotify.OnMountLoaded, self._onMountLoaded, self)
	end

	self.avatarMo = DressModel.instance:getAvatarMoByOrigin(SceneMainPlayer.instance.userVar)
	self.avatarMo.mount = mountId
	self.avatarMo.isMount = true

	self._avatar:updateByMo(self.avatarMo)

	if self._mountPart then
		self._mountPart:onEnter(mountId, self._goodsCfg.id, self._isSellMulMount)
	end
end

function PayshoppetdetailView:_onMountLoaded()
	self:_updateTransform()

	local playerGo = self._avatar:getGameObject()

	if playerGo then
		goutil.setActive(playerGo, true)
	end
end

function PayshoppetdetailView:_updateTransform()
	local mountCo = MountConfig.instance:getMountCo(self._selectMountId)

	if mountCo then
		local x, y, z = 0, 0, 0
		local scale = 1

		if mountCo.position then
			x = mountCo.position[1] or 0
			y = mountCo.position[2] or 0
			z = mountCo.position[3] or 0
		end

		scale = mountCo.scale

		if mountCo.scale == 0 then
			scale = 1
		end

		Framework.TransformUtil.SetLocalPos(self._avatarRoot.transform, x, y, z)
		Framework.TransformUtil.SetLocalScale(self._avatarRoot.transform, scale, scale, scale)
	end
end

function PayshoppetdetailView:_setTitle()
	if self:_isSellPet() then
		self._txtTitle.text = "精灵"
	elseif self:_isSellPetSkin() then
		self._txtTitle.text = "皮肤"
	elseif self:_isSellMount() then
		self._txtTitle.text = "坐骑"
	end
end

function PayshoppetdetailView:_setBgImg()
	if self:_isSellMount() then
		local resName = "ui/bigbg/petdisplay/bg_zq01.png"

		uGuiUtil.setSpriteToImage(self._bgGo, nil, resName)
	else
		local resName = "ui/bigbg/petdisplay/board_jlhd_010.png"

		uGuiUtil.setSpriteToImage(self._bgGo, nil, resName)
	end
end

function PayshoppetdetailView:_isSellPet()
	return self._sellKey == GameEnum.PayShopTabSellType.SellPet
end

function PayshoppetdetailView:_isSellPetSkin()
	return self._sellKey == GameEnum.PayShopTabSellType.SellSkin
end

function PayshoppetdetailView:_isSellMount()
	return self._sellKey == GameEnum.PayShopTabSellType.SellMount
end

function PayshoppetdetailView:_onClickbtnSkill()
	if self._skinId == nil then
		return
	end

	local cfg = PetSkinConfig.instance:getPetSkinCfg(self._skinId)

	if cfg then
		PetbookController.instance:previewBattle(cfg.raceId, self._skinId)
	end
end

function PayshoppetdetailView:_onClickbtnJumpTo()
	GotoMgr.gotoByString(self._goodsCfg.jumpTo)
end

function PayshoppetdetailView:_onClickBtnSellOut()
	FloatWordMgr.instance:show("已售罄")
end

function PayshoppetdetailView:_loadMountActiveData()
	local mounts = MountModel.instance:getLockmounts()
	local mountsKV = {}

	for i, v in ipairs(mounts) do
		mountsKV[v.mountId] = true
	end

	local mountCfgs = MountConfig.instance:getAllMounts()

	for i, v in ipairs(mountCfgs) do
		self._mountActiveItems[v.activationItem] = {
			mountId = v.id,
			isActive = mountsKV[v.id]
		}
	end
end

function PayshoppetdetailView:_checkSellKeySellOut(id)
	local isSellOut = false

	if not PayShopModel.instance:getPayShopGoodsCanBuyById(id) then
		return true
	end

	local goodsCfg = PayShopConfig.instance:getPayShopGoodsCfgById(id)
	local content = goodsCfg.content

	if self:_isSellMount() then
		local arr = string.split(content, "#")

		for i, str in ipairs(arr) do
			if self._mountActiveItems[str] and self._mountActiveItems[str].isActive then
				isSellOut = true

				break
			end
		end
	elseif self:_isSellPetSkin() and (string.find(content, "^" .. MatType.PET_SKIN .. ":") or string.find(content, ".*#" .. MatType.PET_SKIN .. ":")) then
		local arr1 = string.split(content, "#")

		for i, v in ipairs(arr1) do
			if string.find(v, "^" .. MatType.PET_SKIN .. ":") then
				local arr2 = string.split(v, ":")
				local matId = checkint(arr2[2])
				local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(matId)
				local skinStatus = PetskinController.instance:checkHasSkinStatus(petSkinCfg)

				isSellOut = skinStatus == PetskinController.SKIN_STATUS_HAD

				break
			end
		end
	end

	return isSellOut
end

function PayshoppetdetailView:_setGoldBar()
	local btn_list = {
		{
			showAdd = false,
			id = GameEnum.GoldType.Diamond
		},
		{
			showAdd = false,
			id = GameEnum.GoldType.MountCoin
		},
		{
			showAdd = false,
			id = GameEnum.GoldType.GodDiamondCoin
		}
	}

	if self:_isSellPetSkin() then
		table.insert(btn_list, {
			showAdd = false,
			id = GameEnum.GoldType.PifuCoin
		})
	end

	MainUIController.instance:showGlodBar(self._goldBarConGo, self._viewPresentor, btn_list, false)
end

function PayshoppetdetailView:_setDiscountTip(discountDesc)
	discountDesc = discountDesc or ""

	if self:_isSellMount() then
		self._txtDiscountTip.text = ""

		return
	end

	self._txtDiscountTip.text = discountDesc
end

function PayshoppetdetailView:_NotifyPayShopItemBuySucRes()
	self:reloadData()
	self:_checkSellOut()
end

function PayshoppetdetailView:_isJumpGoods()
	return self._goodsCfg.payType == GameEnum.PayShopPayType.JUMPGOODS
end

function PayshoppetdetailView:_checkSellOut()
	goutil.setActive(self._btnSellOut.gameObject, self:_checkSellKeySellOut(self._goodsDefineId))
end

function PayshoppetdetailView:_payShopSelectMountId(mountId, goodsId)
	self._secondSelectMountId = mountId
	self._goodsDefineId = goodsId

	if self._discountPlanId and self._discountPlanId > 0 then
		self._discountPlanId = PayShopModel.instance:getBestDiscountPlanIdByGoodsDefineId(goodsId)
	end

	self:_updateView()
end

function PayshoppetdetailView:_setDefaultValueIfIsSellMulMount()
	self._isSellMulMount = self:_isSellMount() and self._goodsDefineId <= 0

	if self._isSellMulMount then
		local list = PayShopModel.instance:getMiBaoGoodDatasByTabId(43)
		local newList = PayShopModel.instance:calGoodsDefineId2MountId(list)
		local hasActive = false

		for i, v in ipairs(newList) do
			local isActive = MountController.instance:getIfLock(v.mountId)

			isActive = isActive or MaterialMgr.getMatCount(v.itemStr) > 0

			if isActive then
				hasActive = true
				self._goodsDefineId = v.goodsDefineId

				break
			end
		end

		if not hasActive then
			self._goodsDefineId = newList[1].goodsDefineId
		end

		self._discountPlanId = PayShopModel.instance:getBestDiscountPlanIdByGoodsDefineId(self._goodsDefineId)
	end
end

return PayshoppetdetailView
