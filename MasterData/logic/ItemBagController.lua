-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/itembag/controller/ItemBagController.lua

module("logic.extensions.itembag.controller.ItemBagController", package.seeall)

local ItemBagController = class("ItemBagController", BaseController)

function ItemBagController:ctor()
	ItemBagController.super.ctor(self)
end

function ItemBagController:onInit()
	self:onReset()
	GlobalDispatcher:addListener(GlobalNotify.OnMaterialCountChange, self.onMatChange, self)
	GlobalDispatcher:addListener(GlobalNotify.OnMaterialItemChange, self.onItemCountChange, self)
end

function ItemBagController:onReset()
	self.revertList = {}
	self.hasRevert = false
	self.boxRpMap = {}
end

function ItemBagController:openCurrUseItemPanel()
	local data = ItemBagModel.instance:getCurrItem()

	self:openUsePanel(data)
end

function ItemBagController:openUsePanel(data)
	if data.type == MatType.PetPiece then
		self:onPetPieceMerge(data)
	else
		local cfg = MaterialConfig.instance:getCfgByMatAndId(data.type, data.id)

		if cfg then
			if self:checkCanUse(cfg) then
				if cfg.materialUseType == MatUseType.EXCHANGE then
					self:onPieceExchange(data, cfg)
				elseif cfg.materialUseType == MatUseType.PACK or cfg.materialUseType == MatUseType.WEIGHT_PACK then
					UIStateManager.instance:push(ViewName.Itemproc, ItemProcView.TYPE_USED, data, cfg)
				elseif cfg.materialUseType == MatUseType.STRENGTH_RECOVER then
					FuncOpenController.instance:openFunc(57)
				elseif cfg.materialUseType == MatUseType.TREASURE then
					UIStateManager.instance:push(ViewName.Itemproc, ItemProcView.TYPE_USED, data, cfg)
				elseif cfg.materialUseType == MatUseType.MIX_SELECT then
					if checknumber(cfg.specialShow) == 1 then
						UIStateManager.instance:push(ViewName.WulonggiftView, data, cfg)
					else
						UIStateManager.instance:push(ViewName.RewarmultidselectView, data, cfg)
					end
				elseif cfg.materialUseType == MatUseType.MIX_SELECT_ONCE then
					UIStateManager.instance:push(ViewName.RewardselectonceView, data, cfg)
				elseif cfg.materialUseType == MatUseType.GOLDEN_DIAMOND_CARD then
					UIStateManager.instance:push(ViewName.Itemproc, ItemProcView.TYPE_USED, data, cfg)
				else
					printError(">>>> 没有此类型的物品使用方法，可以自己加上去")
				end
			end
		else
			local defineId = data:getDefineId()
			local mattype = data:getMatType()
			local subType = data:GetSubType()

			if subType == MatType.Item_ConsumeLottery then
				UIStateManager.instance:push(ViewName.ConsumeinfoView)
			elseif subType == MatType.Item_Flower then
				FuncOpenController.instance:openFunc(22)
			else
				printError(">>>> 物品使用表里面 没有 配置。 跑前端自定义使用  但还是没指定功能 ！！", mattype, defineId)
			end
		end
	end
end

function ItemBagController:openCurQuickUsePanel()
	local data = ItemBagModel.instance:getCurrItem()
	local cfg = MaterialConfig.instance:getCfgByMatAndId(data.type, data.id)

	if cfg and self:checkCanUse(cfg) then
		if cfg.materialUseType == MatUseType.TREASURE then
			local mapCfg = TreasureNewConfig.instance:getMapCfgByMatId(data.id)

			if mapCfg then
				if RoleModel.instance:getMyLevel() >= mapCfg.directGainLevel then
					UIStateManager.instance:push(ViewName.Itemproc, ItemProcView.TYPE_USED, data, cfg, true)
				else
					FloatWordMgr.instance:show(langPara("快速使用功能于%s级后开启", mapCfg.directGainLevel))
				end
			end
		else
			printError(">>>> 没有此类型的物品使用方法，可以自己加上去")
		end
	end
end

function ItemBagController:openEvolvePanel()
	local data = ItemBagModel.instance:getCurrItem()
	local itemStr = MaterialMgr.createSerName(data:getMatType(), data:getDefineId(), data:GetCount())

	printInfo("test openEvolvePanel", itemStr)

	local evolveMo = EvolveMo.New()

	evolveMo:setParamByItemStr(itemStr)
	UIStateManager.instance:push(ViewName.Evolve, evolveMo)
end

function ItemBagController:onPieceExchange(data, useCfg)
	if useCfg then
		local count, _type, _id, _num = MaterialConfig.instance:getMergeCfgByMatAndId(data.type, data.id)

		if _type == MatType.Item_Badge then
			BadgeController.instance:getBadgeInfo(function()
				if BadgeModel.instance:getBadgeInfoById(_id) then
					local matName = MaterialMgr.getMaterialsName(_type, _id)

					FloatWordMgr.instance:show(langPara("不能进行合成操作，只能拥有1个%s噢", matName))
				else
					UIStateManager.instance:push(ViewName.Itemmerge, data, useCfg)
				end
			end)
		else
			UIStateManager.instance:push(ViewName.Itemmerge, data, useCfg)
		end
	end
end

function ItemBagController:onPetPieceMerge(data)
	local cfg = MaterialMgr.getMatCfg(data.type, data.id)

	if cfg then
		local curNum = MaterialFacade.instance:getMatNumber(data.type, data.id)
		local needNum = cfg.needPieceNum

		if needNum <= curNum then
			local nume = MaterialMgr.getMaterialsName(data.type, data.id)

			TipsFacade.instance:openPopupWindow(lang("tip"), langPara("确定要把%s精灵碎片合成精灵吗？", name), function()
				PetAgent.instance:sendPM_CompositePetPiecesReq(data.id, function(msg)
					FloatWordMgr.instance:show(lang("合成成功"))
				end)
			end)
		else
			FloatWordMgr.instance:show(lang("碎片不足，不能合成"))
		end
	end
end

function ItemBagController:checkCanUse(cfg)
	local lvl = checknumber(cfg.roleLevelLimit)
	local myLvl = RoleModel.instance:getMyLevel()

	if not string.nilorempty(cfg.useStartTime) then
		local useStartTime = GameUtil.string2time(cfg.useStartTime)

		if useStartTime > ServerTime.now() then
			local date = GameUtil.string2date(cfg.useStartTime)
			local str = string.format("[%s] %s年%s月%s日%s时%s分后可打开", cfg.materialName, date.year, date.month, date.day, date.hour, date.min)

			FloatWordMgr.instance:show(str)

			return false
		end
	end

	if lvl <= myLvl then
		return true
	elseif not cfg.des then
		local desc = lang("需要训练师等级达到%d级后%s")

		if not cfg.useDesc then
			local useDes = lang("使用")

			TipsFacade.instance:openTipWindowNoX(lang("tip"), langPara(desc, lvl, useDes), function()
				return
			end)

			return false
		end
	end
end

function ItemBagController:checkCanUseNotWithTips(cfg)
	local lvl = checknumber(cfg.roleLevelLimit)
	local myLvl = RoleModel.instance:getMyLevel()

	if not string.nilorempty(cfg.useStartTime) then
		local useStartTime = GameUtil.string2time(cfg.useStartTime)

		if useStartTime > ServerTime.now() then
			return false
		end
	end

	if lvl <= myLvl then
		return true
	else
		return false
	end
end

function ItemBagController:onItemCountChange(mo)
	if mo:GetCount() == 0 and mo:GetMatType() == MatType.Item then
		local id = mo:getDefineId()
		local cfg = MaterialMgr.getMatCfg(MatType.Item, id)

		if cfg and cfg.subType == 10 then
			local curKey = RedPointModel.ID_BAG_BOX_PRE .. id

			self.boxRpMap[curKey] = nil
		end
	end
end

function ItemBagController:onMatChange()
	self:revertRcd()
	self:updateItems()
	self:updatePetPrice()
	self:upatePet()
	self:updateActiveItems()
end

function ItemBagController:revertRcd()
	for i, v in ipairs(self.revertList) do
		RedPointController.instance:setRedPointInfo(v, false, false)

		self.hasRevert = true
	end

	self.revertList = {}
end

function ItemBagController:updateActiveItems()
	local list = MaterialMgr.getModelList(MatType.ACTIVITY_ITEM)

	for k, mo in pairs(list) do
		local id = mo.id
		local curKey = RedPointModel.ID_BAG_ACT_PRE .. id
		local cfg = MaterialMgr.getMatCfg(MatType.ACTIVITY_ITEM, id)

		if cfg then
			if GameUtil.checkIsInTimePeriod(cfg.startTime, cfg.endTime) then
				RedPointController.instance:setRedPointInfo(curKey, true)
				table.insert(self.revertList, curKey)
			end
		else
			print(">>>>>>>>>>>>>>不存在的 活动道具", id)
		end
	end
end

function ItemBagController:upatePet()
	TimeWheelController.instance:updateRedPoint()
end

function ItemBagController:updatePetPrice()
	local list = MaterialMgr.getModelList(MatType.PetPiece)
	local boo = false

	for k, mo in pairs(list) do
		local petId = mo.id
		local petCfg = CharacterConfig.instance:getPetCo(petId)
		local needPieceNum = checknumber(petCfg.needPieceNum)
		local num = MaterialModel.instance:getMaterialsNumber(MatType.PetPiece, petId)
		local curKey = RedPointModel.ID_HANDBOOK_PRE .. petId

		if needPieceNum <= num then
			boo = true

			RedPointController.instance:setRedPointInfo(curKey, true, false)
			table.insert(self.revertList, curKey)
		else
			RedPointController.instance:setRedPointInfo(curKey, false, false)
		end
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_BAG, boo)
end

function ItemBagController:updateItems()
	local list = MaterialMgr.getModelList(MatType.Item)
	local boo = false

	for k, mo in pairs(list) do
		local id = mo.id
		local curKey = RedPointModel.ID_BAG_PIECE_PRE .. id
		local cfg = ItemConfig.instance:getCfgById(id)

		if cfg then
			if cfg.useType == 2 then
				local myNum = MaterialModel.instance:getMaterialsNumber(MatType.Item, id)
				local count, _type, _id, _num = MaterialConfig.instance:getMergeCfgByMatAndId(MatType.Item, id)

				if count > -1 and count <= myNum then
					boo = true

					RedPointController.instance:setRedPointInfo(curKey, true, false)
					table.insert(self.revertList, curKey)
				end
			end

			if cfg.subType == 10 then
				curKey = RedPointModel.ID_BAG_BOX_PRE .. id

				RedPointController.instance:setRedPointInfo(RedPointModel.ID_BAG_BOX_PRE .. id, true, false)
				table.insert(self.revertList, curKey)

				if self.boxRpMap[curKey] == nil then
					self.boxRpMap[curKey] = true

					RedPointController.instance:setRedPointInfo(RedPointModel.ID_BAG_BOX, true)
				end
			end
		end
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_BAG_PIECE, boo)
end

function ItemBagController:checkItemChangeWhenGet(itemStrs, callBack)
	itemStrs = itemStrs or ""

	local temp = string.split(itemStrs, "#")

	for i, v in ipairs(temp) do
		if self:_checkDress(v, callBack) then
			return true
		end

		if self:_checkMount(v, callBack) then
			return true
		end

		if self:_checkPetskin(v, callBack) then
			return true
		end
	end

	return false
end

function ItemBagController:_checkDress(itemStr, callBack)
	local arr = string.split(itemStr, ":")
	local type = checknumber(arr[1])
	local id = checknumber(arr[2])
	local day = checknumber(arr[3])

	if type == MatType.Cloth then
		local cfg = MaterialMgr.getMatCfg(type, id)
		local hasDress = DressModel.instance:getIsOwnDressById(id)

		if hasDress then
			local tmpType, tmpId, tmpNum = 0, 0, 0
			local count = 1

			if day > 0 then
				tmpType, tmpId, tmpNum = MaterialMgr.getMatParams(cfg.timeLimitTransMp)
				count = day
			else
				tmpType, tmpId, tmpNum = MaterialMgr.getMatParams(cfg.ForeverTransMp)
			end

			local name1 = MaterialMgr.getMaterialsName(type, id)
			local content = langPara("已获得<color=#cd7800>【%s】</color>，再次获得将转化为<color=#cd7800>【%s】</color>，是否确定？", name1, MaterialMgr.getMaterialsName(tmpType, tmpId) .. "x" .. count * tmpNum)

			TipsFacade.instance:openPopupWindow(lang("tip"), content, callBack)

			return true
		end
	end

	return false
end

function ItemBagController:_checkMount(itemStr, callBack)
	local type, id, num = MaterialMgr.getMatParams(itemStr)
	local mountId = MountConfig.instance:getMountInMap(type, id)

	if mountId ~= nil and (MaterialModel.instance:getMaterialsNumber(type, id) > 0 or MountModel.instance:getLockmountsById(mountId) ~= false) then
		local name1 = MaterialMgr.getMaterialsName(type, id)
		local name2 = ""
		local cfg = MountConfig.instance:getMountCo(mountId)
		local mtype, _, count = 0, 0, 0

		if cfg and cfg.overflowRefund then
			name2 = MaterialMgr.getMaterialsNameByCfg(cfg.overflowRefund)
			mtype, _, count = MaterialMgr.getMatParams(cfg.overflowRefund)
		end

		local content = langPara("已获得坐骑<color=#cd7800>【%s】</color>，再次获得将转化为<color=#cd7800>【%sx%s】</color>，是否确定？", name1, name2, count)

		TipsFacade.instance:openPopupWindow(lang("tip"), content, callBack)

		return true
	end

	return false
end

function ItemBagController:_checkPetskin(itemStr, callBack)
	local arr = string.split(itemStr, ":")
	local matType = checknumber(arr[1])
	local id = checknumber(arr[2])
	local day = checknumber(arr[3])

	if matType == MatType.PET_SKIN then
		local skinCfg = PetSkinConfig.instance:getPetSkinCfg(id)

		if PetskinController.instance:checkHasForeverSkinBySkinId(id) then
			local tmpType, tmpId, tmpNum = 0, 0, 0
			local count = 1

			if day > 0 then
				tmpType, tmpId, tmpNum = MaterialMgr.getMatParams(skinCfg.timeLimitTransMp)
				count = day
			else
				tmpType, tmpId, tmpNum = MaterialMgr.getMatParams(skinCfg.ForeverTransMp)
			end

			local content = langPara("已获得精灵皮肤<color=#cd7800>【%s】</color>，再次获得将转化为<color=#cd7800>【%s】</color>，是否确定？", skinCfg.skinName, MaterialMgr.getMaterialsName(tmpType, tmpId) .. "x" .. count * tmpNum)

			TipsFacade.instance:openPopupWindow(lang("tip"), content, callBack)

			return true
		else
			local skinGroup = checknumber(skinCfg.skinGroup)
			local list = PetSkinConfig.instance:getPetSkinListBySkinGroup(skinGroup)
			local hasPet = false

			for i, v in ipairs(list) do
				hasPet = hasPet or BagPetsController.instance:getPetNumByRaceId(v.raceId) > 0
			end

			if not hasPet and day > 0 then
				local petName = MaterialMgr.getMaterialsName(MatType.Pet, skinCfg.raceId)

				TipsFacade.instance:openPopupWindow(lang("tip"), langPara("使用此道具会获得体验皮肤【%s】，您还未获得可穿戴该皮肤的精灵，是否确定使用体验卡兑换该皮肤体验权？", skinCfg.skinName), callBack)

				return true
			end
		end
	end

	return false
end

function ItemBagController:showLimitTipsWithType(type)
	local num = 0
	local name = ""
	local petCount = ItemBagModel.instance:getMaxLvlSSRPetNum()

	if type == MatType.Equipment then
		num = checknumber(EquipmentConfig.instance:getCommonValue("MAX_QUANTITY"))
		name = "装备"
	elseif type == MatType.StarGodPlus then
		num = checknumber(StargodplusConfig.instance:getCommonValue("MAX_QUANTITY"))
		name = "星神"
	elseif type == MatType.HolyStripe then
		num = checknumber(HolyStripeConfig.instance:getParamsValue("NUM_UP"))
		name = "灵纹"
	end

	local list = MaterialMgr.getModelList(type) or {}
	local total, addPercent = ItemBagModel.instance:getLimitTotalNum(petCount, num)
	local petStartLine = ItemBagModel.instance:getPetStartLine()
	local incrCapacityPetGap = ItemBagModel.instance:getIncrCapacityPetGap()
	local gapAddPercent = ItemBagModel.instance:getGapAddPercent()
	local maxCapacity = ItemBagModel.instance:getMaxCapacity()
	local cur = langPara("%s/%s", #list, total)
	local content = langPara("txt_equip_limit_desc", name, num, petStartLine, incrCapacityPetGap, gapAddPercent, maxCapacity, addPercent, cur)

	TipsFacade.instance:openTipWindowNoXBig(lang("tip"), content, nil, "知道了", UnityEngine.TextAnchor.MiddleLeft)
end

function ItemBagController:getCurrLiitWithType(type)
	local num = 0
	local petCount = ItemBagModel.instance:getMaxLvlSSRPetNum()

	if type == MatType.Equipment then
		num = checknumber(EquipmentConfig.instance:getCommonValue("MAX_QUANTITY"))
	elseif type == MatType.StarGodPlus then
		num = checknumber(StargodplusConfig.instance:getCommonValue("MAX_QUANTITY"))
	elseif type == MatType.HolyStripe then
		num = checknumber(HolyStripeConfig.instance:getParamsValue("NUM_UP"))
	end

	local list = MaterialMgr.getModelList(type) or {}
	local total = ItemBagModel.instance:getLimitTotalNum(petCount, num)

	return #list, total
end

ItemBagController.instance = ItemBagController.New()

return ItemBagController
