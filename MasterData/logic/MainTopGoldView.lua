-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/MainTopGoldView.lua

module("logic.extensions.mainui.view.MainTopGoldView", package.seeall)

local MainTopGoldView = class("MainTopGoldView", ViewComponent)

function MainTopGoldView:ctor()
	MainTopGoldView.super.ctor(self)
end

function MainTopGoldView:bindEvents()
	MainTopGoldView.super.bindEvents(self)
end

function MainTopGoldView:unbindEvents()
	MainTopGoldView.super.unbindEvents(self)
end

function MainTopGoldView:buildUI()
	MainTopGoldView.super.buildUI(self)

	self._parent = self:getGo("Nego_Res")
	self._cloneGo = self:getGo("Nego_Res/Nego_TabCell")
	self._itemGroup = ItemGroup.New(self._parent, self._cloneGo, nil, nil, true)
end

function MainTopGoldView:destroyUI()
	MainTopGoldView.super.destroyUI(self)

	self._itemGroup = nil
end

function MainTopGoldView:onEnter()
	MainTopGoldView.super.onEnter(self)
	self:onRefresh()
	GlobalDispatcher:addListener(GlobalNotify.OnMaterialCountChange, self._updateItem, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataTiliCount, self._updateItem, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataEnergyCount, self._updateItem, self)
end

function MainTopGoldView:onEnterFinished()
	MainTopGoldView.super.onEnterFinished(self)
end

function MainTopGoldView:onRefresh()
	local objList = MainuiModel.instance:getObjList()
	local dataList = {}

	for i, v in ipairs(objList) do
		local matStr = v.id

		if matStr and not string.nilorempty(matStr) then
			local matType, matId, matNum = MaterialMgr.getMatParams(matStr)

			if matType == MatType.ACTIVITY_ENERGY then
				EnergyController.instance:_sendGetEnergyInfoReq(matId)
			end

			local data = {
				matStr = matStr,
				obj = v
			}

			table.insert(dataList, data)
		end
	end

	self.itemDataList = dataList

	self:_updateItem()
end

function MainTopGoldView:_updateItem()
	if self.itemDataList then
		local function updateItem(item, data)
			local function callBack()
				if data.obj.showAdd then
					if data.obj.showAddCallBack then
						data.obj.showAddCallBack()
					else
						self:_onClickAddBtn(data.obj.id, data.matStr, item.mainGO)
					end
				end
			end

			local function callbackOnClickItemIcon()
				self:_onClickItemIcon(data.matStr, item.mainGO)
			end

			local component = MainTopGoldItem.AddOnce(item.mainGO)
			local typeId = data.obj.id
			local txt = self:_getItemText(typeId, data.matStr, data.obj.params)
			local spriteType, iconUrl = self:_getItemIcon(typeId, data.matStr)
			local addBtnActive = data.obj.showAdd

			component:setData(item.index, typeId, txt, spriteType, iconUrl, addBtnActive, callBack, callbackOnClickItemIcon)
		end

		self._itemGroup:updateWithMoArray(self.itemDataList, updateItem)
	end
end

function MainTopGoldView:_onClickAddBtn(type, matStr, go)
	local matType, matId, matNum = MaterialMgr.getMatParams(matStr)

	if type == GameEnum.GoldType.Coin then
		MaterialMgr.openGetSourceByStr(GameEnum.GoldType.Coin)
	elseif type == GameEnum.GoldType.Diamond then
		FuncOpenController.instance:openFunc(95, GameEnum.PayShopEasyJump.Recharge)
		SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickDiamondChargeButton)
	elseif type == GameEnum.GoldType.Tili then
		FuncOpenController.instance:openFunc(57)
	elseif type == GameEnum.GoldType.PixieDust then
		MaterialMgr.openGetSource(MatType.Coin, MatType.Coin_Dust)
	elseif type == GameEnum.GoldType.SeniorArenaTicket then
		SeniorArenaController.instance:popBuyTicketWindow()
	elseif type == GameEnum.GoldType.MirrorChip then
		YearCardLotteryController.instance:openBuyCostMatView()
	elseif type == GameEnum.GoldType.ThanksCoin then
		CommonTipsMgr.instance:openTipsByConfStr(go, matStr)
	elseif matType == MatType.ACTIVITY_ENERGY then
		EnergyController.instance:openEnergyJump(matId)
	else
		TipsFacade.instance:openItemSourceView(matStr)
	end
end

function MainTopGoldView:_onClickItemIcon(matStr, go)
	local matType, matId, matNum = MaterialMgr.getMatParams(matStr)

	printInfo("test MainTopGoldView:_onClickItemIcon", matType, matId, matNum)
	CommonTipsMgr.instance:openMaterialTips(go, matType, matId)
end

function MainTopGoldView:_getItemText(type, matStr, params)
	local resault, str = self:_getCustomTxt(params)

	if resault then
		return str
	end

	local matMo = string.splitToNumber(matStr, ":")

	if type == GameEnum.GoldType.Tili then
		local hasTili = MaterialModel.instance:getMaterialsNumber(matMo[1], matMo[2])

		str = hasTili .. "/" .. SupplyModel.instance:getTiliCommonInfo().freeMaxHF
	elseif type == GameEnum.GoldType.Diamond then
		local diamond = RoleModel.instance:getPresentDiamond()
		local payDiamond = RoleModel.instance:getPayDiamond()

		return diamond + payDiamond
	elseif matMo[1] == MatType.ACTIVITY_ENERGY then
		local id = matMo[2]
		local hasNum = EnergyModel.instance:getCurEnergy(id)
		local cfg = EnergyConfig.instance:getEnergyCfg(id)

		return hasNum .. "/" .. cfg.recoveryLimit
	else
		local matMo = string.splitToNumber(matStr, ":")
		local type = matMo[1]
		local id = matMo[2]

		if type == MatType.Coin and id == MatType.Coin_Gold then
			local count = MaterialModel.instance:getMaterialsNumber(type, id)

			str = count < 0 and "<color=#c83c49>" .. count .. "</color>" or count
		else
			str = MaterialModel.instance:getMaterialsNumber(type, id)
		end
	end

	return str
end

function MainTopGoldView:_getCustomTxt(params)
	local resault, str = false

	if params and params.moduleName and params.customTxt then
		resault = true

		if params.moduleName == "JackpotView" and params.actId then
			local actCfg = JackpotConfig.instance:getActCfgById(params.actId)
			local cost = string.split(actCfg.activityItem, ":")
			local has_num = MaterialFacade.instance:getMatNumber(checknumber(cost[1]), checknumber(cost[2]))
			local useNum = checknumber(cost[3])

			str = useNum <= has_num and "<color=#60ee85>" .. has_num .. "</color>" or "<color=#eb4642>" .. has_num .. "</color>"
		end
	end

	return resault, str
end

function MainTopGoldView:_getItemIcon(type, matStr)
	local spriteType = uGuiUtil.SpriteType.BigBg
	local iconUrl = ""
	local matMo = string.splitToNumber(matStr, ":")
	local cfg = MaterialMgr.getMatCfg(matMo[1], matMo[2])

	if cfg then
		local icon = cfg.icon

		iconUrl = GameUrl.getItemIconUrl(icon)
	end

	return spriteType, iconUrl
end

function MainTopGoldView:onExit()
	MainTopGoldView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.OnMaterialCountChange, self._updateItem, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataTiliCount, self._updateItem, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataEnergyCount, self._updateItem, self)
end

function MainTopGoldView:onExitFinished()
	MainTopGoldView.super.onExitFinished(self)
end

return MainTopGoldView
