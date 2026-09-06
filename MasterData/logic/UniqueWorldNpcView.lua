-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/uniqueworld/view/UniqueWorldNpcView.lua

module("logic.extensions.uniqueworld.view.UniqueWorldNpcView", package.seeall)

local UniqueWorldNpcView = class("UniqueWorldNpcView", ViewComponent)

function UniqueWorldNpcView:ctor()
	UniqueWorldNpcView.super.ctor(self)
end

function UniqueWorldNpcView:unbindEvents()
	UniqueWorldNpcView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function UniqueWorldNpcView:bindEvents()
	UniqueWorldNpcView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function UniqueWorldNpcView:buildUI()
	UniqueWorldNpcView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("select/btnSure")
	self._imgCostHas = self:getGo("cost/imgCostHas")
	self._txtCostHas = self:getTxt("cost/txtHas")
	self._imgCostNeed = self:getGo("cost/imgCostNeed")
	self._txtNeed = self:getTxt("cost/txtNeed")
	self._imgNpc = self:getGo("bg/imgNpc")
	self._txtDescript = self:getTxt("select/txtDescript")
	self._tableview = self:getGo("select/tableviewSelect")
	self._tablecell = self:getGo("select/tableviewSelect/tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function UniqueWorldNpcView:onExit()
	UniqueWorldNpcView.super.onExit(self)
	self._scrollList:dispose()
	MaterialMgr.clearIcon(self._imgCostHas)
	MaterialMgr.clearIcon(self._imgCostNeed)
	uGuiUtil.clearImage(self._imgNpc)
end

function UniqueWorldNpcView:onEnter()
	UniqueWorldNpcView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_UniqueWorldMapChangeRes, self._onMapChangeRes, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 584001
	end

	self._gridId = checknumber(params[2])
	self._eventId = checknumber(params[3])
	self._optionId = 0
	self._info = UniqueWorldModel.instance:getInfo(self._activityId)
	self._mapInfo = self._info and self._info.mapInfo
	self._gameInfo = self._mapInfo and self._mapInfo.gameInfo
	self._npcInfo = self._gameInfo and self._gameInfo.npcInfo

	local actCfg = UniqueWorldConfig.instance:getActCfg(self._activityId)

	if actCfg then
		self._coinMatStr = actCfg.coinMatStr or ""
	end

	self._npcCfg = UniqueWorldConfig.instance:getNpcCfg(self._eventId)
	self._npcEventCfgs = UniqueWorldConfig.instance:getNpcEventCfg(self._eventId)
	self._skinId = self._npcCfg and self._npcCfg.skinId
	self._petHpMap = UniqueWorldModel.instance:getPetHpMap(self._activityId)

	self._scrollList:reloadData(self._npcEventCfgs)

	if self._gameInfo then
		if not self._gameInfo.leftCoin then
			self._txtCostHas.text = 0
			self._txtNeed.text = 0
			self._txtDescript.text = self._npcCfg.desc

			local matType, matId, matNum = MaterialMgr.getMatParams(self._coinMatStr)
			local npcSkinId = self._npcCfg.skinId

			MaterialMgr.setIcon(self._imgCostNeed, matType, matId, nil, nil)
			MaterialMgr.setIcon(self._imgCostHas, matType, matId, nil, nil)

			local modelCo = CharacterConfig.instance:getModelCo(npcSkinId)

			uGuiUtil.setSpriteToImage(self._imgNpc, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
		end
	end
end

function UniqueWorldNpcView:_updateCell(view, cell, data)
	local btnSelect = goutil.findChild(cell, "btnSelect")
	local imgGouXuan = goutil.findChild(cell, "btnSelect/imgGouXuan")
	local imgSelect = goutil.findChild(cell, "btnSelect/imgSelect")
	local txtSelect = goutil.findChildTextComponent(cell, "btnSelect/txtSelect")

	txtSelect.text = data.optionDesc

	GameUtil.SetActive(imgGouXuan, self._optionId == data.optionId)
	GameUtil.SetActive(imgSelect, self._optionId == data.optionId)
	GameUtil.addClickHandler(btnSelect, function()
		self._optionId = data.optionId

		self._scrollList:reloadData(self._npcEventCfgs)

		self._effectMap = self:_getEffectMap()

		local needCoin = self._effectMap[UniqueWorldEnum.EffectType.Coin]

		self._txtNeed.text = math.abs(checknumber(needCoin))
	end, self)
end

function UniqueWorldNpcView:_clearCell(cell)
	local btnSelect = goutil.findChild(cell, "btnSelect")

	GameUtil.rmClickHandler(btnSelect)
end

function UniqueWorldNpcView:_onClickSure()
	if self._optionId <= 0 then
		FloatWordMgr.instance:show("尚未选择选项，请选择后再确认")

		return
	end

	local costCoin = self._effectMap[UniqueWorldEnum.EffectType.Coin]
	local isAddPet = self._effectMap[UniqueWorldEnum.EffectType.AddPet] ~= nil

	if self._gameInfo then
		if not self._gameInfo.leftCoin then
			local leftCoin = 0

			if checknumber(costCoin) ~= 0 and leftCoin < math.abs(costCoin) then
				FloatWordMgr.instance:show("积分不足")

				return
			end

			if isAddPet then
				local creepsId = checknumber(self._effectMap[UniqueWorldEnum.EffectType.AddPet])
				local hp = self._petHpMap[creepsId]

				if hp ~= nil then
					FloatWordMgr.instance:show("已获得该精灵，无法重复选择")

					return
				end
			end

			local param = self._optionId .. ""

			UniqueWorldController.instance:sendPM_UniqueWorldDoEventReq(self._activityId, self._gridId, param)
		end
	end
end

function UniqueWorldNpcView:_onMapChangeRes()
	self:_showDesc()
	self:close()
end

function UniqueWorldNpcView:_getEffectMap()
	local effectMap = {}

	if self._optionId > 0 then
		if not self._optionId then
			local curOptionId = 1
			local effectCfg = self._npcEventCfgs[curOptionId]
			local effects = effectCfg.effects
			local effectList = UniqueWorldController.instance:getEffectList(effects)

			for i, effectTb in ipairs(effectList) do
				local effect = effectTb.effect

				if effect == UniqueWorldEnum.EffectType.AddItem then
					effectMap[effect] = effectMap[effect] or {}

					local list = effectMap[effect]
					local id = effectTb.id
					local itemNum = effectTb.num
					local itemCfg = UniqueWorldConfig.instance:getItemCfg(id)

					if itemCfg then
						if not itemCfg.name then
							local itemName = ""

							table.insert(list, {
								name = itemName,
								num = itemNum
							})
						end
					end
				elseif effect == UniqueWorldEnum.EffectType.Coin then
					effectMap[effect] = checknumber(effectTb.num)
				elseif effect == UniqueWorldEnum.EffectType.AddPet then
					effectMap[effect] = checknumber(effectTb.num)
				elseif effect == UniqueWorldEnum.EffectType.AddEvent then
					effectMap[effect] = {
						type = effectTb.id,
						eventId = effectTb.num
					}
				end
			end

			return effectMap
		end
	end
end

function UniqueWorldNpcView:_showDesc()
	if self._optionId > 0 then
		if not self._optionId then
			local curOptionId = 1
			local effectCfg = self._npcEventCfgs[curOptionId]
			local effects = effectCfg.effects
			local effectList = UniqueWorldController.instance:getEffectList(effects)

			for i, effectTb in ipairs(effectList) do
				local effect = effectTb.effect
				local num = effectTb.num
				local id = effectTb.id

				if effect == UniqueWorldEnum.EffectType.AddEvent then
					if id == UniqueWorldEnum.GridType.Shop then
						FloatWordMgr.instance:show("生成商店")
					elseif id == UniqueWorldEnum.GridType.DigMine then
						FloatWordMgr.instance:show("生成矿")
					end
				elseif effect == UniqueWorldEnum.EffectType.AddPet then
					local petCfg = UniqueWorldConfig.instance:getSystemPetCfg(num)

					if petCfg then
						if not petCfg.creepsName then
							local petName = ""

							FloatWordMgr.instance:show(string.format("成功获得：【%s】", petName))
						end
					end
				end
			end
		end
	end
end

return UniqueWorldNpcView
