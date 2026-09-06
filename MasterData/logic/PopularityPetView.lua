-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/popularitylist/view/PopularityPetView.lua

module("logic.extensions.popularitylist.view.PopularityPetView", package.seeall)

local PopularityPetView = class("PopularityPetView", ViewComponent)

function PopularityPetView:unbindEvents()
	PopularityPetView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._skillBtn:RemoveClickListener()
	self._petBookBtn:RemoveClickListener()
end

function PopularityPetView:bindEvents()
	PopularityPetView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._skillBtn:AddClickListener(self._onClickSkill, self)
	self._petBookBtn:AddClickListener(self._onClickPetBook, self)
end

function PopularityPetView:buildUI()
	PopularityPetView.super.buildUI(self)

	self._closeBtn = self:getBtn("topleft/btnClose")
	self._role = self:getGo("mask/role")
	self._petBasicCell = self:getGo("petInfo/Viewport/Content/basicImage")
	self._petInfoHeight = self:getGo("petInfo/Viewport"):GetComponent(goutil.Type_RectTransform)
	self._petInfoParent = self:getGo("petInfo/Viewport/Content"):GetComponent(goutil.Type_RectTransform)
	self._petInfoCell = self:getGo("CharacterImage")
	self._strategy = self:getGo("petInfo/Viewport/Content/strategy"):GetComponent(goutil.Type_RectTransform)
	self._txtBestPosition = self:getTxt("petInfo/Viewport/Content/strategy/txtBestPosition")
	self._txtStrategy = self:getTxt("petInfo/Viewport/Content/strategy/txtStrategy")
	self._skillBtn = self:getBtn("skillBtn")
	self._petBookBtn = self:getBtn("petBookBtn")
end

function PopularityPetView:onExit()
	PopularityPetView.super.onExit(self)

	self._roleObj = RoleObjectPool.instance:removeRole(self._roleObj)
end

function PopularityPetView:onEnter()
	PopularityPetView.super.onEnter(self)
	Framework.TransformUtil.SetAnchoredPos(self._petInfoParent, 0, 0)

	self._skinId = self:getFirstParam()
	self._raceId = PetSkinConfig.instance:getPetSkinRaceId(self._skinId)

	local displayBagOffset = CharacterConfig.instance:getModelUIPosAndScale("drawing", self._skinId)
	local x, y, scale = 0, 0, 1

	if displayBagOffset then
		x = checknumber(displayBagOffset[1])
		y = checknumber(displayBagOffset[2])
		scale = displayBagOffset[3] or 1
	end

	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, self._skinId, self._role, scale, nil, true, x, y)

	self:_setPetBasicInfo()
	self:_setPetInfo()

	local petInfo = CharacterConfig.instance:getPetInfoCo(self._skinId)

	if petInfo.raceId == nil then
		petInfo = CharacterConfig.instance:getPetInfoCo(self._raceId)
	end

	self._strategy.transform:SetAsLastSibling()

	self._txtBestPosition.text = string.format("推荐站位: <color=#4F569BFF>%s</color>", petInfo.bestPosition or "无")
	self._txtStrategy.text = petInfo.stragegy and string.gsub(petInfo.stragegy, "\n", "，") or ""

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._petInfoParent)
end

function PopularityPetView:_setPetBasicInfo()
	local basicInfo = HandbookController.instance:getPetBasicInfo(self._skinId)
	local name = goutil.findChildTextComponent(self._petBasicCell, "name/txt")
	local sex = goutil.findChildTextComponent(self._petBasicCell, "sex/txt")
	local birthday = goutil.findChildTextComponent(self._petBasicCell, "birthday/date")
	local height = goutil.findChildTextComponent(self._petBasicCell, "height/txt")
	local weight = goutil.findChildTextComponent(self._petBasicCell, "weight/txt")
	local birthplace = goutil.findChildTextComponent(self._petBasicCell, "birthplace/txt")

	name.text = basicInfo.name

	if basicInfo.sex == 1 then
		sex.text = "女"
	elseif basicInfo.sex == 2 then
		sex.text = "男"
	else
		sex.text = "未知"

		FloatWordMgr.instance:show("性别设置错误")
	end

	birthday.text = basicInfo.birthday
	height.text = basicInfo.height
	weight.text = basicInfo.weight
	birthplace.text = basicInfo.birthplace
end

function PopularityPetView:_setPetInfo()
	self.petInfoCells = self.petInfoCells or {}

	local petInfo = HandbookConfig.instance:getPetInfo(self._skinId)

	if petInfo == nil then
		petInfo = HandbookConfig.instance:getPetInfo(self._raceId)
	end

	if petInfo == nil then
		FloatWordMgr.instance:show("该精灵资料不存在")

		return
	end

	for i = 1, #petInfo do
		if self.petInfoCells[i] == nil then
			table.insert(self.petInfoCells, goutil.cloneAndSetParent(self._petInfoCell, self._petInfoParent))
		end

		self:_setPetInfoCell(self.petInfoCells[i], petInfo[i])
	end

	if #petInfo < #self.petInfoCells then
		for i = #self.petInfoCells, #petInfo + 1, -1 do
			goutil.destroy(self.petInfoCells[i])

			self.petInfoCells[i] = nil
		end
	end
end

function PopularityPetView:_setPetInfoCell(cell, data)
	if data == nil then
		FloatWordMgr.instance:show("该精灵资料" .. HandbookController.instance:numberToChinese(data.order) .. "未知")

		return
	end

	goutil.setActive(cell, true)

	local openCondition = string.split(data.openCondition, ",")

	goutil.findChildTextComponent(cell, "CharacterInfo").text = "人物资料" .. HandbookController.instance:numberToChinese(data.order)

	local rect = cell:GetComponent(goutil.Type_RectTransform)

	if FuncOpenController.instance:checkCondition(openCondition) then
		goutil.setActive(goutil.findChild(cell, "lock"), false)

		goutil.findChildTextComponent(cell, "content").text = data.content

		local contentRect = goutil.findChildComponent(cell, "content", goutil.Type_RectTransform)

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(contentRect)
		goutil.setHeight(rect, goutil.getHeight(contentRect) + 75)
	else
		goutil.setActive(goutil.findChild(cell, "content"), false)
		goutil.setActive(goutil.findChild(cell, "lock"), true)

		goutil.findChildTextComponent(cell, "lock/txt").text = data.lockedTips

		goutil.setHeight(rect, 140)
	end
end

function PopularityPetView:_onClickSkill()
	PetbookController.instance:previewBattleWithSkinId(self._skinId)
end

function PopularityPetView:_onClickPetBook()
	if self._skinId == self._raceId then
		PetbookController.instance:openPetinfoViewNoSetAttr(self._skinId)
	else
		PetbookController.instance:openSkinViewNoSetAttr(self._skinId)
	end
end

return PopularityPetView
