-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/CardInfoPetSkinShowView.lua

module("logic.extensions.roleinfo.view.CardInfoPetSkinShowView", package.seeall)

local CardInfoPetSkinShowView = class("CardInfoPetSkinShowView", ViewComponent)

function CardInfoPetSkinShowView:buildUI()
	CardInfoPetSkinShowView.super.buildUI(self)

	self._goTable = self:getGo("tableview")
	self._goCell = self:getGo("cell")
	self._tableView = ScrollerList.create(self._goTable, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._tableviewScrollrect = self._goTable:GetComponent("ScrollRect")
	self._turn = self:getGo("turn")
	self._btnLeft = goutil.findChild(self._turn, "btnLeft")
	self._btnRight = goutil.findChild(self._turn, "btnRight")
	self._imgQuality = goutil.findChildComponent(self._turn, "imgQuality", "UIImageSpriteChange")
	self._goTableTurn = goutil.findChild(self._turn, "tableview")
	self._goCellTurn = goutil.findChild(self._turn, "cell")
	self._tableViewTurn = ScrollerList.create(self._goTableTurn, self._goCellTurn, GameUtil.handler(self._updateCellTurn, self), GameUtil.handler(self._clearCellTurn, self))
	self._drag = Framework.UIDragTrigger.Get(goutil.findChild(self._goTableTurn, "uidrag"))
	self._scrollrect = self._goTableTurn:GetComponent("ScrollRect")
	self._content = goutil.findChild(self._goTableTurn, "viewport/content")
	self._con = self:getGo("con")
	self._txtProgress = self:getTxt("progress/txtProgress")
	self._empty = self:getGo("empty")
	self._showQualitys = {}
	self._turnQualitys = {}

	for i = 1, 9 do
		if i ~= 4 then
			table.insert(self._showQualitys, i)
			table.insert(self._turnQualitys, i)
		end
	end

	self._changeCellId = 3

	local temFirstIds = {}
	local temEndIds = {}

	for i = 1, self._changeCellId do
		local firstId = self._turnQualitys[#self._turnQualitys - i + 1]

		table.insert(temFirstIds, firstId)

		local endId = self._turnQualitys[i]

		table.insert(temEndIds, endId)
	end

	for i = 1, self._changeCellId do
		table.insert(self._turnQualitys, 1, temFirstIds[i])
		table.insert(self._turnQualitys, temEndIds[i])
	end
end

function CardInfoPetSkinShowView:bindEvents()
	CardInfoPetSkinShowView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnLeft, self._onClickLeft, self)
	GameUtil.addClickHandler(self._btnRight, self._onClickRight, self)
	self._drag:AddEndDragListener(self._onDragEnd, self)
	self._drag:AddDragListener(self._onDrag, self)
	self._drag:AddBeginDragListener(self._onBeginDrag, self)
end

function CardInfoPetSkinShowView:unbindEvents()
	CardInfoPetSkinShowView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnLeft)
	GameUtil.rmClickHandler(self._btnRight)
	self._drag:RemoveEndDragListener()
	self._drag:RemoveDragListener()
	self._drag:RemoveBeginDragListener()
end

function CardInfoPetSkinShowView:onEnter()
	CardInfoPetSkinShowView.super.onEnter(self)

	local userId = self:getFirstParam()

	self._curShowId = 1

	self._tableViewTurn:MoveCellToBegin(2)
	self._tableViewTurn:reloadData(self._turnQualitys)
	PetskinController.instance:sendGetInfo(function()
		if userId then
			local var_5_0 = PetskinModel.instance:getOtherUserOwnSkinListBySkinGroup()

			if not var_5_0 then
				var_5_0 = PetskinModel.instance:getUserOwnSkinListBySkinGroup()

				local skinList = var_5_0

				self._skinList = {}

				for ql, ls in pairs(skinList) do
					for si, cfg in pairs(ls) do
						self._skinList[ql] = self._skinList[ql] or {}

						if cfg.isHide ~= 1 then
							self._skinList[ql][si] = cfg
						end
					end
				end

				self._curShowId = -1

				local tableBeginId = 2

				for i = #self._showQualitys, 1, -1 do
					local skinQuality = self._showQualitys[i]

					if self._curShowId < 0 then
						if table.nums(self._skinList[skinQuality] or {}) > 0 then
							self._curShowId = i
							tableBeginId = i + 1
						end
					end
				end

				if self._curShowId < 0 then
					self._curShowId = 1
				end

				self._tableViewTurn:MoveCellToBegin(tableBeginId)
				self:_onTurn()
			end
		end
	end, userId)
end

function CardInfoPetSkinShowView:onExit()
	CardInfoPetSkinShowView.super.onExit(self)

	self._showCfg = nil

	self._tableView:dispose()
	self._tableViewTurn:dispose()

	self._role = RoleObjectPool.instance:removeRole(self._role)
end

function CardInfoPetSkinShowView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)
	local faceId = checknumber(data.skinId)
	local modelCo = CharacterConfig.instance:getModelCo(faceId)
	local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(faceId)
	local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx(faceId)

	goutil.setActive(cell.markShow, self._showCfg == data)
	goutil.setActive(cell.select, self._showCfg == data)
	uGuiUtil.setSpriteToImage(cell.con, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
	GameUtil.addClickHandler(cell.btn, GameUtil.handler(self._onClickTab, self, data))

	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(faceId)

	cell.txtName.text = PetSkinConfig.instance:getPetSkinName(faceId)
	race = race % 10

	local targetValue = race - 1

	if cell.iconAttr then
		cell.iconAttr:SetState(targetValue)
	end

	if cell.iconJob then
		cell.iconJob:SetState(firstJobIdx - 1)
		GameUtil.SetActive(cell.iconJob1.gameObject, false)

		if secondJobIdx > 20 then
			GameUtil.SetActive(cell.iconJob1.gameObject, true)
			cell.iconJob1:SetState(secondJobIdx - 1 - 20)
		end
	end
end

function CardInfoPetSkinShowView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.btn = goutil.findChild(cell.go, "container")
	cell.con = goutil.findChild(cell.btn, "mask/con")
	cell.markShow = goutil.findChild(cell.btn, "markShow")
	cell.select = goutil.findChild(cell.btn, "select")
	cell.txtName = goutil.findChildTextComponent(cell.btn, "txtName")
	cell.iconJob = goutil.findChildComponent(cell.btn, "layout/Nego_Job/ImgC_Job", "UIImageSpriteChange")
	cell.iconJob1 = goutil.findChildComponent(cell.btn, "layout/Nego_Job1/ImgC_Job", "UIImageSpriteChange")
	cell.iconAttr = goutil.findChildComponent(cell.btn, "layout/Nego_Attr/Img_attr", "UIImageSpriteChange")
	cell.txtName.text = ""

	uGuiUtil.clearImage(cell.con)
	GameUtil.rmClickHandler(cell.btn)

	return cell
end

function CardInfoPetSkinShowView:_onClickTab(data)
	if self._showCfg ~= data then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._showCfg = data

		if self._showCfg then
			local skinId = self._showCfg.skinId
			local displayBagOffset = CharacterConfig.instance:getModelUIPosAndScale("cardinfolihui", skinId, "baglihui")
			local x, y, scale = 0, 0, 1

			if displayBagOffset then
				x = checknumber(displayBagOffset[1])
				y = checknumber(displayBagOffset[2])
				scale = displayBagOffset[3] or 1
			end

			self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, scale, nil, true, x, y)

			self._tableView:refresh()
		end
	end
end

function CardInfoPetSkinShowView:_onClickLeft()
	self._curShowId = self._curShowId - 1

	if self._curShowId < 1 then
		self._curShowId = #self._showQualitys
	end

	self:_onTurn()
end

function CardInfoPetSkinShowView:_onClickRight()
	self._curShowId = self._curShowId + 1

	if self._curShowId > #self._showQualitys then
		self._curShowId = 1
	end

	self:_onTurn()
end

function CardInfoPetSkinShowView:_onTurn()
	local curQuality = self._showQualitys[self._curShowId]

	self._imgQuality:SetState(curQuality - 1)

	if not self._skinList[curQuality] then
		local dataList = {}

		for k, v in pairs(self._skinList[curQuality]) do
			if string.nilorempty(v.showTime) then
				table.insert(dataList, v)
			else
				local showTime = GameUtil.string2time(v.showTime)

				if showTime < ServerTime.now() then
					table.insert(dataList, v)
				end
			end
		end

		self._tableviewScrollrect.verticalNormalizedPosition = 1

		self._tableView:reloadData(dataList)
		goutil.setActive(self._empty, #dataList == 0)
		self:_onClickTab(dataList[1])

		local totalPetNum = 0

		for k, v in pairs(PetSkinConfig.instance:getPetSkinListByQuality(curQuality)) do
			if checknumber(MaterialMgr.getMatCfg(MatType.Pet, v.raceId).bookIds) <= 0 then
				-- block empty
			elseif string.nilorempty(v.showTime) then
				if PetSkinConfig.instance:isExistSkinGroup(v.skinId) then
					if PetSkinConfig.instance:isMainSkinCfgBySkinGroup(v) then
						totalPetNum = totalPetNum + 1
					end
				else
					totalPetNum = totalPetNum + 1
				end
			else
				local showTime = GameUtil.string2time(v.showTime)

				if showTime < ServerTime.now() then
					if PetSkinConfig.instance:isExistSkinGroup(v.skinId) then
						if PetSkinConfig.instance:isMainSkinCfgBySkinGroup(v) then
							totalPetNum = totalPetNum + 1
						end
					else
						totalPetNum = totalPetNum + 1
					end
				end
			end
		end

		local curProgress = totalPetNum == 0 and 0 or checknumber(#dataList * 100 / totalPetNum)

		printInfo("test 收集进度", #dataList, totalPetNum)

		self._txtProgress.text = langPara("收集进度：<color=#20B376FF>%.2f%%</color>", curProgress)

		GameUtil.setAnchoredPos(self._content, (self._curShowId + 1) * -100, -100)
	end
end

function CardInfoPetSkinShowView:_updateCellTurn(view, goCell, data)
	local cell = self:_clearCellTurn(goCell)

	cell.change:SetState(data)
end

function CardInfoPetSkinShowView:_clearCellTurn(goCell)
	local cell = {}

	cell.go = goCell
	cell.change = cell.go:GetComponent("UIImageSpriteChange")

	return cell
end

function CardInfoPetSkinShowView:_onDrag(eventData)
	self._scrollrect:OnDrag(eventData)

	local pos = GameUtil.getAnchoredPos(self._content)

	if pos then
		if not pos.x then
			local conX = 0

			if conX > -100 then
				GameUtil.setAnchoredPos(self._content, -700 + conX, -100)
			elseif conX < -900 then
				GameUtil.setAnchoredPos(self._content, conX + 700, -100)
			end
		end
	end
end

function CardInfoPetSkinShowView:_onBeginDrag(eventData)
	self._scrollrect:OnBeginDrag(eventData)
end

function CardInfoPetSkinShowView:_onDragEnd(eventData)
	local pos = GameUtil.getAnchoredPos(self._content)

	if pos then
		if not pos.x then
			local conX = 0

			if conX >= -100 then
				conX = -800
			elseif conX <= -900 then
				conX = -200
			end

			local curId = checkint(conX / -100) - 1

			curId = MathUtil.clamp(curId, 1, #self._showQualitys)

			if self._curShowId ~= curId then
				self._curShowId = curId

				self:_onTurn()
			else
				GameUtil.setAnchoredPos(self._content, (self._curShowId + 1) * -100, -100)
			end
		end
	end
end

return CardInfoPetSkinShowView
