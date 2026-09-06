-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangjingroad/view/ChuangjingroadpetlistView.lua

module("logic.extensions.chuangjingroad.view.ChuangjingroadpetlistView", package.seeall)

local ChuangjingroadpetlistView = class("ChuangjingroadpetlistView", ViewComponent)

function ChuangjingroadpetlistView:ctor()
	ChuangjingroadpetlistView.super.ctor(self)
end

function ChuangjingroadpetlistView:unbindEvents()
	ChuangjingroadpetlistView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnBuy)
end

function ChuangjingroadpetlistView:bindEvents()
	ChuangjingroadpetlistView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnBuy, self._onClickBuy, self)
end

function ChuangjingroadpetlistView:buildUI()
	ChuangjingroadpetlistView.super.buildUI(self)

	self._btnBuy = self:getGo("btnBuy")
	self._summon = self:getGo("summon")
	self._con = self:getGo("summon/con")
	self._goldBarCon = self:getGo("goldBarCon")
	self._starGodList = {}

	for i = 1, 4 do
		local cell = self:getGo("starGod/cell_" .. i)

		table.insert(self._starGodList, cell)
	end

	self._txtDesc = self:getTxt("holyStripes/txtDesc")
	self._txtName = self:getTxt("holyStripes/txtName")
	self._icon = self:getGo("holyStripes/icon")
	self._tablecell = self:getGo("tablecell")
	self._tableview = self:getGo("tableview")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function ChuangjingroadpetlistView:onExit()
	ChuangjingroadpetlistView.super.onExit(self)
	self._scrollList:dispose()
	uGuiUtil.clearImage(self._icon)
end

function ChuangjingroadpetlistView:onEnter()
	ChuangjingroadpetlistView.super.onEnter(self)

	self._activityId = 396001

	local params = self:getOpenParam() or {}
	local actId = checknumber(params[1])

	if actId > 0 then
		self._activityId = actId
	end

	self._selectPetId = 0

	self.addGEvent(self, GlobalNotify.CHUANG_JING_ROAD_PET_INFO_UPDATE, self._onRefershUI, self)
	ChuangJingRoadController.instance:sendGetPetInfo(self._activityId)
	self:_onRefershUI()

	local cfg = ChuangJingRoadConfig.instance:getActivityCfgById(self._activityId)

	if cfg and not string.nilorempty(cfg.buyCost) then
		local list = string.split(cfg.buyCost, "#")
		local objList = {}

		for i, v in ipairs(list) do
			local tem = {
				showAdd = true,
				id = v
			}

			table.insert(objList, tem)
		end

		MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, objList)
	end
end

function ChuangjingroadpetlistView:_onRefershUI()
	local info = ChuangJingRoadModel.instance:getPetInfo(self._activityId) or {}

	self._unlockCreepIds = info.unlockCreepIds or {}
	self._level = checknumber(info.level)
	self._awakenLv = checknumber(info.awakenLv)
	self._equipmentLv = checknumber(info.equipmentLv)
	self._starGodPlusLv = checknumber(info.starGodPlusLv)
	self._holyStripeLv = checknumber(info.holyStripeLv)

	local cfglist = ChuangJingRoadConfig.instance:getSupportListById(self._activityId) or {}

	self._petMap = {}

	local list = {}

	for i, v in ipairs(cfglist) do
		self._petMap[v.creepsId] = v

		if checknumber(v.summonMasterId) == 0 then
			table.insert(list, v)

			if #list == 1 and self._selectPetId == 0 then
				self._selectPetId = v.creepsId
			end
		end
	end

	self._scrollList:reloadData(list)
	self:_showRighView()
end

function ChuangjingroadpetlistView:_updateCell(view, cell, data, tag)
	local con = goutil.findChild(cell, "con")
	local summon = goutil.findChild(cell, "summon")
	local has = goutil.findChild(cell, "has")
	local select = goutil.findChild(cell, "select")
	local txtCost = MaterialMgr.findGraphicText(cell, "txtCost")
	local proxy = MaterialMgr.setCell(MatType.Pet, data.raceId, con)

	if proxy then
		proxy.binder:setClickCallBack(GameUtil.handler(self._onClickPet, self, data.creepsId))
	end

	GameUtil.SetActive(summon, checknumber(data.summonedPetId) > 0)
	GameUtil.SetActive(select, self._selectPetId == data.creepsId)

	local boo = table.indexof(self._unlockCreepIds, data.creepsId) ~= false

	GameUtil.SetActive(has, boo)

	txtCost.text = ""

	if not boo then
		local cost = data.cost

		if not string.nilorempty(cost) then
			local type, id, num = MaterialMgr.getMatParams(cost)
			local iconStr = MaterialMgr.getContentMatStr(cost, 26, -5, true)

			txtCost.text = iconStr .. "" .. num
		end
	end

	GameUtil.addClickHandler(cell, GameUtil.handler(self._onClickCell, self, data))
end

function ChuangjingroadpetlistView:_clearCell(cell)
	local con = goutil.findChild(cell, "con")

	MaterialMgr.resetAll(con)
end

function ChuangjingroadpetlistView:_showRighView()
	if not self._petMap[self._selectPetId] then
		local data = {}

		if not data.fixedStarGodId then
			local fixedStarGodId = {}

			for i, cell in ipairs(self._starGodList) do
				local fillerDefineId = fixedStarGodId[i]

				GameUtil.SetActive(cell, false)

				if checknumber(fillerDefineId) > 0 then
					GameUtil.SetActive(cell, true)

					local iconGo = goutil.findChild(cell, "icon")
					local nameText = goutil.findChildTextComponent(cell, "nameText")
					local nameTextColorChange = nameText.gameObject:GetComponent(ComponentType.UITextColorChange)

					nameText.text = MaterialMgr.getMaterialsName(MatType.StarGodPlus, fillerDefineId)

					MaterialMgr.setIcon(iconGo, MatType.StarGodPlus, fillerDefineId)

					local cfg = StargodplusConfig.instance:getFillerCfg(fillerDefineId)
					local quality = checknumber(cfg.quality)

					nameTextColorChange:SetState(quality)
					GameUtil.addClickHandler(cell, GameUtil.handler(self.onClickStarGodPlusCell, self, cell, fillerDefineId))
				end
			end

			self._txtName.text = data.holyStripeSuitName
			self._txtDesc.text = data.holyStripeSuitDesc

			uGuiUtil.setSpriteToImage(self._icon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(data.imgUrl))
			GameUtil.SetActive(self._summon, checknumber(data.summonedPetId) > 0)

			if checknumber(data.summonedPetId) > 0 then
				local petCfg = self._petMap[checknumber(data.summonedPetId)]
				local proxy = MaterialMgr.setCell(MatType.Pet, petCfg.raceId, self._con)

				if proxy then
					proxy.binder:setClickCallBack(GameUtil.handler(self._onClickPet, self, checknumber(data.summonedPetId)))
				end
			end

			local boo = table.indexof(self._unlockCreepIds, data.creepsId) ~= false

			GameUtil.SetGray(self._btnBuy, boo)
		end
	end
end

function ChuangjingroadpetlistView:_onClickCell(data)
	self._selectPetId = data.creepsId

	self._scrollList:refresh()
	self:_showRighView()
end

function ChuangjingroadpetlistView:_onClickPet(creepsId)
	local map = ChuangJingRoadModel.instance:getPetMoMap(self._activityId) or {}
	local petMo = map[creepsId]

	if petMo then
		petMo = ChuangJingRoadModel.instance:updatePetMo(self._activityId, petMo, self._level, self._awakenLv, self._equipmentLv, self._starGodPlusLv, self._holyStripeLv)

		CommonTipsMgr.instance:showPetTips(petMo)
	end
end

function ChuangjingroadpetlistView:_onClickBuy()
	local boo = table.indexof(self._unlockCreepIds, self._selectPetId) ~= false

	if not boo then
		local data = self._petMap[self._selectPetId]

		if data then
			local cost = data.cost

			if not string.nilorempty(cost) then
				local type, id, num = MaterialMgr.getMatParams(cost)
				local iconStr = MaterialMgr.getContentMatStr(cost, 26, -5, true)
				local petName = MaterialMgr.getMaterialsName(MatType.Pet, data.raceId)
				local content = langPara("确定要花费%s%s招募%s吗？", iconStr, num, petName)

				TipsFacade.instance:openPopupCostMatViewNew(type, id, num, content, function()
					ChuangJingRoadController.instance:sendBuyPet(self._activityId, self._selectPetId)
				end)
			end
		end
	end
end

function ChuangjingroadpetlistView:onClickStarGodPlusCell(cell, fillerDefineId)
	return
end

return ChuangjingroadpetlistView
