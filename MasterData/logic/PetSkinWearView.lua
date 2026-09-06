-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petskin/view/PetSkinWearView.lua

module("logic.extensions.petskin.view.PetSkinWearView", package.seeall)

local PetSkinWearView = class("PetSkinWearView", ViewComponent)

function PetSkinWearView:ctor()
	PetSkinWearView.super.ctor(self)
end

function PetSkinWearView:buildUI()
	PetSkinWearView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._skinIcon = self:getGo("skinshow/mask/skinIcon")
	self._rare = self:getGo("skinshow/rare")
	self._txtName = self:getTxt("skinshow/txtName")
	self._btnWear = self:getBtn("btnWear")
	self.scrollerGo = self:getGo("tableview")
	self.cellGo = self:getGo("cell")
	self.scrollList = ScrollerList.create(self.scrollerGo, self.cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function PetSkinWearView:bindEvents()
	PetSkinWearView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnWear:AddClickListener(self._onClickWear, self)
end

function PetSkinWearView:unbindEvents()
	PetSkinWearView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnWear:RemoveClickListener()
end

function PetSkinWearView:onEnter()
	PetSkinWearView.super.onEnter(self)
	GlobalDispatcher:addListener(PetSkinAgent.PM_BatchUsePetSkinRes, self._onUsePetSkinRes, self)

	local params = self:getOpenParam()

	self._skinId = params[1]
	self._onWearSuccessCallback = params[2]
	self._cfgPetSkin = PetSkinConfig.instance:getPetSkinCfg(self._skinId)
	self._skinGroup = self._cfgPetSkin.skinGroup
	self._selectPetMap = {}

	self:_refreshPetSkin()
	self:_initPetList()
end

function PetSkinWearView:onExit()
	PetSkinWearView.super.onExit(self)
	GlobalDispatcher:removeListener(PetSkinAgent.PM_BatchUsePetSkinRes, self._onUsePetSkinRes, self)
	self.scrollList:dispose()
end

function PetSkinWearView:_onClickWear()
	local wearPetList = {}

	for k, v in pairs(self._selectPetMap) do
		local element = {}
		local cfg = PetSkinConfig.instance:getPetSkinCfgBySkinGroupAndRaceId(self._skinGroup, v.raceId)

		if cfg then
			element.skinId = cfg.skinId or 0
		end

		element.petId = v.petId

		table.insert(wearPetList, element)
	end

	if #wearPetList > 0 then
		PetSkinAgent.instance:sendPM_BatchUsePetSkinReq(wearPetList)
	else
		FloatWordMgr.instance:show("请先选择精灵")
	end
end

function PetSkinWearView:_onUsePetSkinRes()
	FloatWordMgr.instance:show("穿戴成功！")
	GameUtil.callBack(self._onWearSuccessCallback)
	self:close()
end

function PetSkinWearView:_refreshPetSkin()
	self._txtName.text = self._cfgPetSkin.skinName

	MaterialMgr.setCell(MatType.PetSkin_Rare, self._skinId, self._rare)

	local modelCo = CharacterConfig.instance:getModelCo(checknumber(self._skinId))

	if modelCo then
		uGuiUtil.setSpriteToImage(self._skinIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
	end
end

function PetSkinWearView:_clearPetSkin()
	MaterialMgr.resetAll(self._rare)
end

function PetSkinWearView:_initPetList()
	local cfgPetSkinList = PetSkinConfig.instance:getPetSkinListBySkinGroup(self._skinGroup)
	local raceIds = {}

	for i, cfg in ipairs(cfgPetSkinList) do
		if not TableUtil.isHad(raceIds, cfg.raceId) then
			table.insert(raceIds, cfg.raceId)
		end
	end

	local targetPetList = {}

	for i, v in ipairs(raceIds) do
		local petMos = BagModel.instance:getPetsByRaceId(v)

		table.insertto(targetPetList, petMos)
	end

	printInfo("test PetSkinWearView:_initPetList = ", #targetPetList)
	self.scrollList:reloadData(targetPetList)
end

function PetSkinWearView:_updateCell(view, cell, data, tag)
	local container = goutil.findChild(cell.gameObject, "container")
	local select = goutil.findChild(cell, "container/select")
	local imgPoint = goutil.findChild(cell, "container/cover/imgPoint")
	local comp = PetShowCard.AddOnce(container)

	comp:setPetMo(data, self)
	comp:setClickCallBack(function()
		if not goutil.isNil(select) then
			local newActive = not select.activeSelf

			goutil.setActive(select, newActive)

			self._selectPetMap[data.petId] = newActive and data or nil
		end
	end)
	goutil.setActive(select, false)
	goutil.setActive(imgPoint, false)
end

function PetSkinWearView:_clearCell(cell)
	return
end

return PetSkinWearView
