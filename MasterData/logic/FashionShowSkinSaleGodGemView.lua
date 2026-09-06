-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dressactivityshop/view/FashionShowSkinSaleGodGemView.lua

module("logic.extensions.dressactivityshop.view.FashionShowSkinSaleGodGemView", package.seeall)

local FashionShowSkinSaleGodGemView = class("FashionShowSkinSaleGodGemView", ViewComponent)

function FashionShowSkinSaleGodGemView:ctor()
	FashionShowSkinSaleGodGemView.super.ctor(self)
end

function FashionShowSkinSaleGodGemView:buildUI()
	FashionShowSkinSaleGodGemView.super.buildUI(self)

	self._mainGo = self.mainGO
	self._bg = goutil.findChild(self._mainGo, "bg")
	self._btnBuy = goutil.findChild(self._mainGo, "btnBuy")
	self._btnBuyItem = goutil.findChild(self._mainGo, "btnBuy/item")
	self._btnBuyTxt = goutil.findChild(self._mainGo, "btnBuy/Text"):GetComponent("Text")
	self._btnClose = goutil.findChild(self._mainGo, "btnClose")
	self._txtTime = goutil.findChild(self._mainGo, "txtTime"):GetComponent("Text")
	self._txtTip = goutil.findChildTextComponent(self._mainGo, "txtTip")
	self._cellsFrame = goutil.findChild(self._mainGo, "cellsFrame")
	self._effectGo = goutil.findChild(self._mainGo, "effectGo")
	self._modsFrame = goutil.findChild(self._mainGo, "modsFrame")
	self.cellList = {}
	self.modList = {}
	self.aimList = {}
	self.effect = nil

	GameUtil.addClickHandler(self._btnBuy, GameUtil.handler(self._onClickTotalBtnBuy, self))
end

function FashionShowSkinSaleGodGemView:bindEvents()
	FashionShowSkinSaleGodGemView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
end

function FashionShowSkinSaleGodGemView:unbindEvents()
	FashionShowSkinSaleGodGemView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnBuy)

	for _, cell in ipairs(self.cellList) do
		GameUtil.rmClickHandler(cell._btnBuy)
	end
end

function FashionShowSkinSaleGodGemView:destroyUI()
	FashionShowSkinSaleGodGemView.super.destroyUI(self)
	self:_clearModel()
end

function FashionShowSkinSaleGodGemView:onEnter()
	FashionShowSkinSaleGodGemView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self.activityId = checknumber(params[1])

	if self.activityId == 0 then
		printError("缺少传入活动id")
		self:close()

		return
	end

	self._runData = DressActivityShopGodGemConfig.instance:getRunData(self.activityId)
	self.cfg_single = DressActivityShopGodGemConfig.instance:getSingleCfgByActId(self.activityId)
	self.cfg_activity = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.DressActivityShopGodGem, self.activityId)

	if self._runData == nil then
		printError(string.format("不存在对应配置,请检查配置表( z支付-服装售卖活动(神钻版).xlsx | export_启动配置 | activityId = %s )", self.activityId))
		self:close()

		return
	end

	if self.cfg_activity then
		self.openTime = GameUtil.string2time(self.cfg_activity.startTime)
		self.endTime = GameUtil.string2time(self.cfg_activity.endTime)
	end

	for index, data in ipairs(self.cfg_single) do
		table.insert(self.cellList, self:_buildCell(index, data))
	end

	local modIndex = 1

	for _, data in ipairs(self.cfg_single) do
		if data.isUseRole == true then
			table.insert(self.modList, self:_buildMod(modIndex, data))

			modIndex = modIndex + 1
		end
	end

	if not string.nilorempty(self._runData.firstRedId) then
		local key = PayTrussGodGemController.MAINHUDFIRSTCLICKREDPOINT .. self.activityId

		PayTrussGodGemController.instance:_hideRedIfOpen(key, self._runData.firstRedId)
	end

	self:_setPanelUI()
	GlobalDispatcher:addListener(PayTrussGodGemAgent.PM_PayTrussGodGemBuyRes, self._onGetPayTrussInfo, self)
	GlobalDispatcher:addListener(PayTrussGodGemAgent.PM_PayTrussGodGemInfoRes, self._onRefreshUI, self)
	self:_onGetPayTrussInfo()
end

function FashionShowSkinSaleGodGemView:onExit()
	FashionShowSkinSaleGodGemView.super.onExit(self)
	UIEffectManager.instance:stopEffect(self.effect)

	self.effect = nil

	MaterialMgr:clearIcon(self._btnBuyItem)

	for _, cell in ipairs(self.cellList) do
		for _, item in ipairs(cell.itemList) do
			MaterialMgr.resetAll(item._mainGo)
		end

		MaterialMgr:clearIcon(cell._costItem)
	end

	GlobalDispatcher:removeListener(PayTrussGodGemAgent.PM_PayTrussGodGemBuyRes, self._onGetPayTrussInfo, self)
	GlobalDispatcher:removeListener(PayTrussGodGemAgent.PM_PayTrussGodGemInfoRes, self._onRefreshUI, self)
	removetimer(self._updateTimer, self)
end

function FashionShowSkinSaleGodGemView:_onGetPayTrussInfo()
	PayTrussGodGemController.instance:_sendPayTrussGodGemInfoReq(self.activityId)
end

function FashionShowSkinSaleGodGemView:_buildCell(index, data)
	local cell = {}

	cell._mainGo = goutil.findChild(self._cellsFrame, "cell" .. index)

	if cell._mainGo == nil then
		printError("配置礼包数量超过预制体设定...")

		return nil
	end

	cell._txtName = goutil.findChildTextComponent(cell._mainGo, "txtName")
	cell._txtBtnBuy = goutil.findChildTextComponent(cell._mainGo, "btnBuy/text")
	cell._txtLimit = goutil.findChildTextComponent(cell._mainGo, "txtLimit")
	cell._btnBuy = goutil.findChild(cell._mainGo, "btnBuy")
	cell._itemcon = goutil.findChild(cell._mainGo, "itemcon")
	cell._soldout = goutil.findChild(cell._mainGo, "soldout")
	cell._costItem = goutil.findChild(cell._mainGo, "btnBuy/costItem")
	cell.data = data
	cell.itemList = {}

	goutil.setActive(cell._txtName.gameObject, true)
	goutil.setActive(cell._btnBuy, true)
	goutil.setActive(cell._txtBtnBuy.gameObject, true)
	goutil.setActive(cell._itemcon, true)
	GameUtil.addClickHandler(cell._btnBuy, GameUtil.handler(self._onClickCellBtnBuy, self, cell))

	local contentArr = string.split(cell.data.giftContent, "#")
	local index = 1

	for _, cfgStr in ipairs(contentArr) do
		local playerGender = checknumber(RoleModel.instance:getGender())
		local strArr = string.split(cfgStr, ":")
		local matType, matId = checknumber(strArr[1]), checknumber(strArr[2])
		local itemCfgStr = ""

		if matType == MatType.Cloth then
			cfg = DressConfig.instance:getDressCfgById(matId)

			if cfg and checknumber(cfg.clothesGender) == playerGender or checknumber(cfg.clothesGender) == GameEnum.Gender.Neutral then
				itemCfgStr = cfgStr
			end
		else
			itemCfgStr = cfgStr
		end

		if not string.nilorempty(itemCfgStr) then
			table.insert(cell.itemList, self:_buildItem(index, itemCfgStr, cell._itemcon))

			index = index + 1
		end
	end

	return cell
end

function FashionShowSkinSaleGodGemView:_buildItem(index, cfgStr, father)
	local item = {}

	item._mainGo = goutil.findChild(father, "item" .. index)

	if item._mainGo == nil then
		printError("配置道具数量超过预制体设定...")

		return nil
	end

	item.cfgStr = cfgStr

	goutil.setActive(item._mainGo, true)

	return item
end

function FashionShowSkinSaleGodGemView:_buildMod(index, data)
	local mod = {}

	mod._mainGo = goutil.findChild(self._modsFrame, "mod" .. index)

	if mod._mainGo == nil then
		return nil
	end

	mod._con = goutil.findChild(mod._mainGo, "con")
	mod._rayTrigger = goutil.findChild(mod._mainGo, "rayTrigger")
	mod._drag = Framework.UIDragTrigger.Get(mod._rayTrigger)
	mod._data = data

	return mod
end

function FashionShowSkinSaleGodGemView:_setPanelUI()
	self:_setActivityTime()

	local hasPurchasedIds = PayTrussGodGemModel.instance:_getPayTrussInfoFormModel()
	local cfg_line_coalition = DressActivityShopGodGemConfig.instance:getSuitCfgByActIdAndHasOwnTab(self.activityId, hasPurchasedIds)

	if cfg_line_coalition ~= nil then
		local priceStrArr = string.split(cfg_line_coalition.price, ":")
		local matType = priceStrArr[1]
		local matId = priceStrArr[2]

		MaterialMgr.setIcon(self._btnBuyItem, matType, matId)
	end

	self._btnBuyTxt.text = "未获取信息"

	uGuiUtil.setGoGrayState(self._btnBuy, true)

	local effPath = "20220128/suichujiarui/fx_ui_suichujiarui.prefab"

	local function func(_, eff)
		eff:setParent(self._effectGo.transform)
		eff:setLocalPos(0, 0, 0)
		eff:setScale(1)
	end

	if self._effectGo ~= nil then
		UIEffectManager.instance:stopEffect(self.effect)

		self.effect = UIEffectManager.instance:playEffect(self, effPath, self._effectGo, 0, 0, true, false, nil, func)
	end

	for _, cell in ipairs(self.cellList) do
		self:_setCellUI(cell)
	end

	if #self.aimList == 0 then
		self:_setModel()
	else
		for _, data in ipairs(self.aimList) do
			data._avatar:updateByMo(data._avatarMo)
		end
	end
end

function FashionShowSkinSaleGodGemView:_setModel()
	local attributes = {
		{
			camSize = 1.3,
			rawSize = {
				1024,
				1024
			},
			camPos = {
				0,
				1.25,
				-5
			},
			mRot = {
				0,
				180,
				0
			},
			conScale = {
				0.45,
				0.45,
				0.45
			}
		},
		{
			camSize = 1.3,
			rawSize = {
				1024,
				1024
			},
			camPos = {
				0,
				1.55,
				-5
			},
			mRot = {
				0,
				180,
				0
			},
			conScale = {
				0.45,
				0.45,
				0.45
			}
		}
	}

	self.aimList = {}

	for i, mod in ipairs(self.modList) do
		local attr = attributes[i]

		if attr ~= nil then
			table.insert(self.aimList, self:_showModel(mod, attr))
		end
	end
end

function FashionShowSkinSaleGodGemView:_showModel(mod, attr)
	local roleGender = GameEnum.Gender.Female

	roleGender = mod._data.gender == GameEnum.Gender.Neutral and checknumber(RoleModel.instance:getGender()) or math.min(checknumber(mod._data.gender), GameEnum.Gender.Male)

	local photoEff = AvatarPhotoShow.Get(mod._con)
	local avatar, avatarMo = AvatarsMgrNew.instance:getAvatarAndMoByCfgId(roleGender + 1)
	local amCtrl

	photoEff:setRawImgNativeSize(false)
	photoEff:setRawWidthAndHeight(attr.rawSize[1], attr.rawSize[2])
	photoEff:setCameraPosition(attr.camPos[1], attr.camPos[2], attr.camPos[3])
	photoEff:setCamSize(attr.camSize)
	photoEff:setRTAdjust(1, 1, 1, 0.1)
	GameUtil.setLocalScale(mod._con, attr.conScale[1], attr.conScale[2], attr.conScale[3])

	local suitId
	local dressIdArr = {}

	if not string.nilorempty(mod._data.suitIds) then
		local strArr = string.split(mod._data.suitIds, "#")

		for _, str in ipairs(strArr) do
			local contentArr = string.split(str, ":")
			local suitGender = checknumber(contentArr[1])

			if suitGender == roleGender or suitGender == GameEnum.Gender.Neutral then
				suitId = checknumber(contentArr[2])
			end
		end
	end

	if not string.nilorempty(mod._data.dressIds) then
		local strArr = string.split(mod._data.dressIds, "#")

		for _, str in ipairs(strArr) do
			local contentArr = string.split(str, ":")
			local dressGender = checknumber(contentArr[1])

			if dressGender == roleGender or dressGender == GameEnum.Gender.Neutral then
				for i = 2, #contentArr do
					table.insert(dressIdArr, contentArr[i])
				end
			end
		end
	end

	local function func(avatarPhotoShow)
		local avatarGo = avatar:getGameObject()
		local suitCfg = DressConfig.instance:getSuitCfgById(checknumber(suitId))

		if suitCfg and not string.nilorempty(suitCfg.ui_animation) then
			amCtrl = TimeLineAnimationController.New(avatarGo, "storyconfig/animations/charactors/" .. suitCfg.ui_animation .. ".txt")

			local camera = photoEff._photoEffect._photo.producer.rtCamera

			amCtrl:setTargets({
				camera.gameObject,
				avatarGo
			})
			amCtrl:startPlay()
		end

		if mod._data.isCanTurn == true then
			mod._drag:RemoveDragListener()
			mod._drag:AddDragListener(self._roleTrun, self, avatar)
		end

		local avFatherGo = avatar:getGameObject().transform.parent

		Framework.TransformUtil.SetLocalRotation(avFatherGo.transform, attr.mRot[1], attr.mRot[2], attr.mRot[3])

		avatarPhotoShow._avatarLoadedhandle = nil
		avatarPhotoShow._avatarLoadedhandleObj = nil
	end

	photoEff:addShowAvatarEffect(avatar, true, func, nil)

	if not string.nilorempty(mod._data.suitIds) then
		local suitCfg = DressConfig.instance:getSuitCfgById(checknumber(suitId))

		if suitCfg ~= nil then
			for _, dressId in ipairs(suitCfg.include) do
				local cfg = DressConfig.instance:getDressCfgById(checknumber(dressId))

				if cfg.partId then
					avatarMo:setDataByCfgId(cfg.partId)
				end
			end
		end
	end

	if not string.nilorempty(mod._data.dressIds) then
		for _, dressId in ipairs(dressIdArr) do
			local cfg = DressConfig.instance:getDressCfgById(checknumber(dressId))

			if cfg.partId then
				avatarMo:setDataByCfgId(cfg.partId)
			end
		end
	end

	if checknumber(mod._data.mountId) > 0 then
		avatarMo.mount = mod._data.mountId
		avatarMo.isMount = true
	end

	avatar:updateByMo(avatarMo)

	local obj = {}

	obj._photoEff = photoEff
	obj._avatar = avatar
	obj._avatarMo = avatarMo
	obj._ctrl = amCtrl

	return obj
end

function FashionShowSkinSaleGodGemView:_roleTrun(eventData, avatar)
	local go = avatar:getGameObject().transform.parent

	if go then
		local localRotation = Quaternion.Euler(0, -0.5 * eventData.delta.x * 1, 0) * go.transform.localRotation
		local eulerAngles = localRotation.eulerAngles

		Framework.TransformUtil.SetLocalRotation(go.transform, 0, eulerAngles.y, 0)
	end
end

function FashionShowSkinSaleGodGemView:_clearModel()
	for _, aim in ipairs(self.aimList) do
		if aim._ctrl ~= nil then
			aim._ctrl:stopPlay()

			aim._ctrl = nil
		end

		if aim._photoEff ~= nil then
			aim._photoEff:clear()

			aim._photoEff = nil
		end

		if aim._avatar ~= nil then
			AvatarsMgrNew.instance:removeAvatar(aim._avatar)

			aim._avatar = nil
		end

		if aim._avatarMo ~= nil then
			aim._avatarMo = nil
		end
	end

	self.aimList = {}
end

function FashionShowSkinSaleGodGemView:_setCellUI(cell)
	cell._txtName.text = cell.data.name or "未配置名称"

	local priceStrArr = string.split(cell.data.price, ":")
	local matType = priceStrArr[1]
	local matId = priceStrArr[2]

	cell._txtBtnBuy.text = priceStrArr[3]

	MaterialMgr.setIcon(cell._costItem, matType, matId)
	uGuiUtil.setGoGrayState(cell._btnBuy, true)

	cell._txtLimit.text = "活动限时：?/?"

	for _, item in ipairs(cell.itemList) do
		self:_setItemUI(item)
	end
end

function FashionShowSkinSaleGodGemView:_setItemUI(item)
	MaterialMgr.setCellByCfg(item.cfgStr, item._mainGo)
end

function FashionShowSkinSaleGodGemView:_setActivityTime()
	local str1 = GameUtil.formatTimeStamp(lang("text_timeinfo_2"), self.openTime)
	local str2 = GameUtil.formatTimeStamp(lang("text_timeinfo_2"), self.endTime)

	self._txtTime.text = str1 .. " ~ " .. str2

	local leftTime = self.endTime - ServerTime.nowServerLook()

	if leftTime <= 0 then
		FloatWordMgr.instance:show(lang("text_equip_desc_1"))

		return
	end

	local readyTime = self.openTime - ServerTime.nowServerLook()

	if readyTime >= 0 then
		FloatWordMgr.instance:show(lang("drawequip_open_tips"))

		return
	end

	if leftTime > 0 then
		settimer(1, self._updateTimer, self, true)
		self:_updateTimer()

		return
	end
end

function FashionShowSkinSaleGodGemView:_updateTimer()
	local leftTime = self.endTime - ServerTime.nowServerLook()

	if leftTime > 0 then
		self._txtTime.text = langPara("text_countdown_dhms", GameUtil.getTimeDDHHMMSS(leftTime))
	else
		FloatWordMgr.instance:show(lang("text_equip_desc_1"))
		removetimer(self._updateTimer, self)
	end
end

function FashionShowSkinSaleGodGemView:_onRefreshUI()
	local hasPurchasedIds = PayTrussGodGemModel.instance:_getPayTrussInfoFormModel()
	local cfg_line_coalition = DressActivityShopGodGemConfig.instance:getSuitCfgByActIdAndHasOwnTab(self.activityId, hasPurchasedIds)
	local isCanBuy = cfg_line_coalition ~= nil

	uGuiUtil.setGoGrayState(self._btnBuy, not isCanBuy)
	goutil.setActive(self._btnBuy, isCanBuy)

	if isCanBuy then
		local value = string.split(cfg_line_coalition.price, ":")[3] or "错误配置"

		self._btnBuyTxt.text = string.format("%s全购", value)
	end

	for _, cell in ipairs(self.cellList) do
		self:_updateCell(cell, hasPurchasedIds)
	end

	local isNeedHideTip = false

	for _, cell in ipairs(self.cellList) do
		local isHasBuy = table.indexof(hasPurchasedIds, cell.data.id) ~= false

		isNeedHideTip = isNeedHideTip or not isHasBuy
	end

	goutil.setActive(self._txtTip.gameObject, isNeedHideTip)
end

function FashionShowSkinSaleGodGemView:_updateCell(cell, hasPurchasedIds)
	for _, cell in ipairs(self.cellList) do
		local isHasBuy = table.indexof(hasPurchasedIds, cell.data.id) ~= false

		GameUtil.SetActive(cell._soldout, isHasBuy)
		GameUtil.SetActive(cell._btnBuy, not isHasBuy)
		uGuiUtil.setGoGrayState(cell._btnBuy.gameObject, isHasBuy)

		cell._txtBtnBuy.text = isHasBuy == true and lang("text_recall_desc_6") or string.split(cell.data.price, ":")[3] or "配置错误"
		cell._txtLimit.text = isHasBuy == true and langPara("text_activity_time_limit_d_d", 0, 1) or langPara("text_activity_time_limit_d_d", 1, 1)
	end

	for _, item in ipairs(cell.itemList) do
		self:_updateItem(item)
	end
end

function FashionShowSkinSaleGodGemView:_updateItem(item)
	return
end

function FashionShowSkinSaleGodGemView:_onClickBtnClose()
	self:close()
end

function FashionShowSkinSaleGodGemView:_onClickCellBtnBuy(cell)
	if self:_isInActivityTime() == false then
		return
	end

	local hasPurchasedIds = PayTrussGodGemModel.instance:_getPayTrussInfoFormModel()
	local isHasBuy = table.indexof(hasPurchasedIds, cell.data.id) ~= false

	if isHasBuy == true then
		FloatWordMgr.instance:show(lang("text_buy_you_have_purchased"))

		return
	end

	local value = ""
	local tips = ""
	local cfg_line_coalition = DressActivityShopGodGemConfig.instance:getSuitCfgByActIdAndHasOwnTab(self.activityId, hasPurchasedIds)

	if cfg_line_coalition == nil then
		local conStr = MaterialMgr.getContentMatStr(cell.data.price, 40, -10, MaterialMgr.ICON_TYPE_ICON)

		value = string.split(cell.data.price, ":")[3] or "错误配置"
		tips = string.format("确定花费%s%s，购买%s吗？", value, conStr, cell._txtName.text)
	else
		local conStr = MaterialMgr.getContentMatStr(cfg_line_coalition.price, 40, -10, MaterialMgr.ICON_TYPE_ICON)

		value = string.split(cfg_line_coalition.price, ":")[3] or "错误配置"
		tips = string.format("购买该礼包后将无法以%s%s一键购买全部礼包，是否继续？", value, conStr)
	end

	local function okFunc()
		local buyId = cell.data.id

		PayTrussGodGemController.instance:_sendPM_PayTrussGodGemBuyReq(self.activityId, buyId)
	end

	local function cencelFunc()
		return
	end

	TipsFacade.instance:openPopupWindow(lang("text_buy_tips"), tips, okFunc, cencelFunc, lang("confirm"), lang("cancel"), nil)
end

function FashionShowSkinSaleGodGemView:_onClickTotalBtnBuy()
	if self:_isInActivityTime() == false then
		return
	end

	local hasPurchasedIds = PayTrussGodGemModel.instance:_getPayTrussInfoFormModel()
	local cfg_line_coalition = DressActivityShopGodGemConfig.instance:getSuitCfgByActIdAndHasOwnTab(self.activityId, hasPurchasedIds)

	if cfg_line_coalition == nil then
		FloatWordMgr.instance:show(lang("text_buy_you_have_purchased"))

		return
	end

	local conStr = MaterialMgr.getContentMatStr(cfg_line_coalition.price, 40, -10, MaterialMgr.ICON_TYPE_ICON)

	value = string.split(cfg_line_coalition.price, ":")[3] or "错误配置"
	tips = string.format("确定花费%s%s，全购此礼包吗？", value, conStr)

	local function okFunc()
		local buyId = -1

		PayTrussGodGemController.instance:_sendPM_PayTrussGodGemBuyReq(self.activityId, buyId)
	end

	local function cencelFunc()
		return
	end

	TipsFacade.instance:openPopupWindow(lang("text_buy_tips"), tips, okFunc, cencelFunc, lang("confirm"), lang("cancel"), nil)
end

function FashionShowSkinSaleGodGemView:_isInActivityTime()
	local leftTime = self.endTime - ServerTime.nowServerLook()

	if leftTime <= 0 then
		FloatWordMgr.instance:show(lang("text_activity_ended_cozy_tips"))

		return false
	end

	local readyTime = self.openTime - ServerTime.nowServerLook()

	if readyTime >= 0 then
		FloatWordMgr.instance:show(lang("text_activity_not_on_cozy_tips"))

		return false
	end

	return true
end

function FashionShowSkinSaleGodGemView:_getCurVersionInfo()
	curVersionInfo = PayTrussGodGemController.curVersionInfos[1]

	return curVersionInfo
end

return FashionShowSkinSaleGodGemView
