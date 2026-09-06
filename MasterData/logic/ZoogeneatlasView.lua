-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZoogeneatlasView.lua

module("logic.extensions.zoo.view.ZoogeneatlasView", package.seeall)

local ZoogeneatlasView = class("ZoogeneatlasView", ViewComponent)

function ZoogeneatlasView:buildUI()
	ZoogeneatlasView.super.buildUI(self)

	self._animalIcon = self:getGo("animalIcon")
	self._leftBtn = self:getBtn("animalIcon/leftBtn")
	self._rightBtn = self:getBtn("animalIcon/rightBtn")
	self._geneIcon = goutil.findChildComponent(self._animalIcon, "geneName/geneIcon", ComponentType.UIImageSpriteChange)
	self._geneImgState = goutil.findChildComponent(self._animalIcon, "imgState", ComponentType.UIImageColorChange)
	self._geneStateText = goutil.findChildTextComponent(self._geneImgState.gameObject, "Text")
	self._geneName = goutil.findChildTextComponent(self._animalIcon, "geneName")
	self._geneInfo = goutil.findChildTextComponent(self._animalIcon, "geneInfo")
	self._seeMyBtn = self:getBtn("animalIcon/seeMyBtn")
	self._progressText = goutil.findChildTextComponent(self.mainGO, "progress")
	self._geneCell = self:getGo("item_gene")
	self._geneGrid = self:getGo("progress/geneGrid")
	self._geneView = ScrollerList.create(self._geneGrid, self._geneCell, GameUtil.handler(self._updateGeneCell, self))
	self._pageText = goutil.findChildTextComponent(self.mainGO, "progress/page")
	self._upBtn = self:getBtn("progress/page/up")
	self._downBtn = self:getBtn("progress/page/down")
	self._typeCell = self:getGo("raceCell")
	self._typeTab = self:getGo("raceTab")
	self._typeView = ScrollerList.create(self._typeTab, self._typeCell, GameUtil.handler(self._updateTypeCell, self))
	self._geneTypeBtns = {}

	for i = 1, 9 do
		self._geneTypeBtns[i] = self:getBtn("geneType/" .. i)
	end

	self._closeBtn = self:getBtn("close")
	self._drag = Framework.UIDragTrigger.Get(self:getGo("animalIcon/drag"))
end

function ZoogeneatlasView:bindEvents()
	ZoogeneatlasView.super.bindEvents(self)
	self._leftBtn:AddClickListener(self._onClickLeft, self)
	self._rightBtn:AddClickListener(self._onClickRight, self)
	self._seeMyBtn:AddClickListener(self._onClickSeeMyAnimal, self)
	self._upBtn:AddClickListener(self._onClickUpPage, self)
	self._downBtn:AddClickListener(self._onClickDownPage, self)
	self._closeBtn:AddClickListener(self.close, self)
	self._drag:AddDragListener(self._onDrag, self)

	for i, btn in ipairs(self._geneTypeBtns) do
		btn:AddClickListener(function()
			self:_onClickGeneType(i)
		end)
	end
end

function ZoogeneatlasView:unbindEvents()
	ZoogeneatlasView.super.unbindEvents(self)
	self._leftBtn:RemoveClickListener()
	self._rightBtn:RemoveClickListener()
	self._seeMyBtn:RemoveClickListener()
	self._upBtn:RemoveClickListener()
	self._downBtn:RemoveClickListener()
	self._closeBtn:RemoveClickListener()
	self._drag:RemoveDragListener()

	for i, btn in ipairs(self._geneTypeBtns) do
		btn:RemoveClickListener()
	end
end

function ZoogeneatlasView:onEnter()
	ZoogeneatlasView.super.onEnter(self)

	self._typeList = {
		{
			type = 0,
			name = lang("tip_all")
		},
		{
			type = 2,
			name = lang("petzoo_genus_head")
		},
		{
			type = 3,
			name = lang("petzoo_genus_back")
		},
		{
			type = 4,
			name = lang("petzoo_genus_weapon")
		},
		{
			type = 5,
			name = lang("petzoo_genus_head_sign")
		},
		{
			type = 6,
			name = lang("petzoo_genus_expression")
		},
		{
			type = 7,
			name = lang("petzoo_genus_clothes")
		},
		{
			type = 8,
			name = lang("petzoo_genus_tail")
		},
		{
			type = 9,
			name = lang("petzoo_genus_work")
		}
	}
	self._selectType = 0
	self._selectRace = 1
	self._typeChange = {}

	self._typeView:reloadData(ZooConfig.instance:getAnimal())
	self:_onClickGeneCell()

	self._page = 1

	self:_loadAllGene()

	for i, btn in ipairs(self._geneTypeBtns) do
		uGuiUtil.setGoGrayState(btn.gameObject, i ~= self._selectType and (self._selectType ~= 0 or i ~= 1))
	end

	self._maxPage = math.ceil(#self._geneList / 15)
	self._progressText.text = string.format(lang("text_collection_progress"), 0, #self._geneList)
	self._defaultAnimalMo = {}

	local animalCfg = ZooConfig.instance:getAnimal()

	for index, cfg in ipairs(animalCfg.dataList) do
		self._defaultAnimalMo[cfg.raceId] = AnimalModel.New()

		self._defaultAnimalMo[cfg.raceId]:getDefaultByRaceId(cfg.raceId)
	end

	self._animalShow, self._avatar = self._defaultAnimalMo[animalCfg.dataList[1].raceId]:showAnimalAvatar(self._animalIcon, 400, 370, 0.6, 0.5)
	self._animalGo = self._avatar:getGameObject()

	GlobalDispatcher:addListener(GlobalNotify.OnZooGetFaceGeneManual, self._getFaceGeneManual, self)
	ZooAgent.instance:sendPM_ZooGetFaceGeneManualReq()
end

function ZoogeneatlasView:onExit()
	ZoogeneatlasView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.OnZooGetFaceGeneManual, self._getFaceGeneManual, self)
end

function ZoogeneatlasView:onExitFinished()
	self._geneView:dispose()
	self._typeView:dispose()
	self._avatar:destroy()
	self._animalShow:clear()
	ZoogeneatlasView.super.onExitFinished(self)
end

function ZoogeneatlasView:_getFaceGeneManual(msg)
	self._activeList = {}

	local num = 0

	for index, value in ipairs(msg.geneId) do
		self._activeList[value] = true
		num = num + 1
	end

	self._progressText.text = string.format(lang("text_collection_progress"), num, #self._geneList)

	self:_updateGenePage()
end

function ZoogeneatlasView:_loadAllGene()
	local _, genes = ZooConfig.instance:getGene()

	self._geneList = {}

	for index, value in ipairs(genes) do
		if value.name ~= "" and value.animalRace == self._selectRace then
			table.insert(self._geneList, value)
		end
	end

	genes = ZooConfig.instance:getWorkGene()

	for index, value in ipairs(genes) do
		table.insert(self._geneList, value)
	end
end

function ZoogeneatlasView:_loadShowGene()
	local _, genes = ZooConfig.instance:getGene()

	self._geneList = {}

	for index, value in ipairs(genes) do
		if value.name ~= "" and value.part == self._selectType and value.animalRace == self._selectRace then
			table.insert(self._geneList, value)
		end
	end
end

function ZoogeneatlasView:_loadWorkGene()
	local genes = ZooConfig.instance:getWorkGene()

	self._geneList = {}

	for index, value in ipairs(genes.dataList) do
		table.insert(self._geneList, value)
	end
end

function ZoogeneatlasView:_updateTypeCell(view, cell, data)
	goutil.findChildTextComponent(cell.gameObject, "Text").text = data.name

	Framework.ButtonAdapter.Get(cell.gameObject):AddClickListener(function()
		self._typeChange[self._selectRace]:SetState(0)

		self._selectRace = data.raceId

		self._typeChange[self._selectRace]:SetState(1)

		for i = 2, 8 do
			local _, genes = ZooConfig.instance:getGene()
			local geneList = {}

			for index, value in ipairs(genes) do
				if value.name ~= "" and value.part == i and value.animalRace == self._selectRace then
					table.insert(geneList, value)
				end
			end

			if #geneList == 0 and self._selectType == i then
				self._selectType = 0
			end

			goutil.setActive(self._geneTypeBtns[i].gameObject, #geneList > 0)
		end

		if self._selectType == 0 then
			self:_loadAllGene()
		elseif self._selectType == 9 then
			self:_loadWorkGene()
		else
			self:_loadShowGene()
		end

		self._page = 1
		self._maxPage = math.ceil(#self._geneList / 15)

		self:_updateGenePage()
	end)

	local change = cell.gameObject:GetComponent(ComponentType.UIImageSpriteChange)

	self._typeChange[data.raceId] = change

	change:SetState(data.raceId == self._selectRace and 1 or 0)
end

function ZoogeneatlasView:_updateGenePage()
	local list = {}

	for i = -14 + self._page * 15, self._page * 15 do
		if self._geneList[i] then
			table.insert(list, self._geneList[i])
		else
			break
		end
	end

	self._geneView:reloadData(list)

	self._pageText.text = string.format(lang("text_pages_num"), self._page, self._maxPage)

	goutil.setActive(self._upBtn.gameObject, self._page > 1)
	goutil.setActive(self._downBtn.gameObject, self._page < self._maxPage)
end

function ZoogeneatlasView:_updateGeneCell(view, cell, data)
	local component = ItemGene.AddOnce(cell.gameObject)

	component:setData(data)
	component:setEffective(false)
	component:setClickCallBack(self._onClickGeneCell, self)
	uGuiUtil.setGoGrayState(cell.gameObject, not self._activeList[data.id])
end

function ZoogeneatlasView:_onClickGeneCell(data)
	goutil.setActive(self._geneIcon.gameObject, data)
	goutil.setActive(self._geneImgState.gameObject, data)

	if data == nil then
		self._geneName.text = ""
		self._geneInfo.text = lang("text_none")
		self._selectGene = nil

		uGuiUtil.setGoGrayState(self._seeMyBtn.gameObject, true)

		return
	end

	local haveFlag = false
	local animalList = ZooModel.instance:getMyAnimalList()

	for i, animal in ipairs(animalList) do
		if animal:isHaveGene(data.geneType, data.id) then
			haveFlag = true

			break
		end
	end

	uGuiUtil.setGoGrayState(self._seeMyBtn.gameObject, not haveFlag)

	if self._activeList[data.id] then
		self._geneImgState:SetState(1)

		self._geneStateText.text = lang("text_hasgot")
	else
		self._geneImgState:SetState(0)

		self._geneStateText.text = lang("text_hasnt_got")
	end

	if data.part then
		self._geneIcon:SetState(data.part - 1)
	else
		self._geneIcon:SetState(8)
	end

	self._geneName.text = data.name
	self._geneInfo.text = (data.desc == nil or data.desc == "") and lang("text_none") or data.desc
	self._selectGene = data

	if data.part then
		self._defaultAnimalMo[data.animalRace]:updateShowGeneById(data.id)

		local avatarMo = self._avatar:getNewUseMo()

		avatarMo:setDataByAnimalMo(self._defaultAnimalMo[data.animalRace])
		self._avatar:updateByMo(avatarMo)
	end
end

function ZoogeneatlasView:_onClickLeft()
	if self._avatar then
		local avatarGo = self._avatar:getGameObject()

		if avatarGo then
			local localRotation = avatarGo.transform.localRotation
			local addAngle = -30
			local eulerAngles = localRotation.eulerAngles

			Framework.TransformUtil.SetLocalRotation(avatarGo.transform, 0, eulerAngles.y + addAngle, 0)
		end
	end
end

function ZoogeneatlasView:_onClickRight()
	if self._avatar then
		local avatarGo = self._avatar:getGameObject()

		if avatarGo then
			local localRotation = avatarGo.transform.localRotation
			local addAngle = 30
			local eulerAngles = localRotation.eulerAngles

			Framework.TransformUtil.SetLocalRotation(avatarGo.transform, 0, eulerAngles.y + addAngle, 0)
		end
	end
end

function ZoogeneatlasView:_onDrag(eventData)
	if self._avatar then
		local avatarGo = self._avatar:getGameObject()

		if avatarGo then
			local localRotation = Quaternion.Euler(0, -0.5 * eventData.delta.x * 1, 0) * avatarGo.transform.localRotation
			local eulerAngles = localRotation.eulerAngles

			Framework.TransformUtil.SetLocalRotation(avatarGo.transform, 0, eulerAngles.y, 0)
		end
	end
end

function ZoogeneatlasView:_onClickSeeMyAnimal()
	if self._selectGene == nil then
		FloatWordMgr.instance:show(lang("petzoo_genes_nosel_genes"))

		return
	end

	local animalList = ZooModel.instance:getMyAnimalList()

	for i, animal in ipairs(animalList) do
		if animal:isHaveGene(self._selectGene.geneType, self._selectGene.id) then
			self:close()
			UIStateManager.instance:push(ViewName.ZooanimalView, animal)

			return
		end
	end

	FloatWordMgr.instance:show(lang("petzoo_genes_noexist_genes_animal"))
end

function ZoogeneatlasView:_onClickUpPage()
	if self._page > 1 then
		self._page = self._page - 1

		self:_updateGenePage()
	end
end

function ZoogeneatlasView:_onClickDownPage()
	if self._page < self._maxPage then
		self._page = self._page + 1

		self:_updateGenePage()
	end
end

function ZoogeneatlasView:_onClickGeneType(index)
	local data = self._typeList[index]

	self._selectType = data.type

	if data.type == 0 then
		self:_loadAllGene()
	elseif data.type == 9 then
		self:_loadWorkGene()
	else
		self:_loadShowGene()
	end

	self._page = 1
	self._maxPage = math.ceil(#self._geneList / 15)

	for i, btn in ipairs(self._geneTypeBtns) do
		uGuiUtil.setGoGrayState(btn.gameObject, i ~= self._selectType and (self._selectType ~= 0 or i ~= 1))
	end

	self:_updateGenePage()
end

return ZoogeneatlasView
