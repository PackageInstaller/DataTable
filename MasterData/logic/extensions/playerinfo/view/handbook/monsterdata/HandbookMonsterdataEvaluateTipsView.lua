-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/monsterdata/HandbookMonsterdataEvaluateTipsView.lua

module("logic.extensions.playerinfo.view.handbook.monsterdata.HandbookMonsterdataEvaluateTipsView", package.seeall)

local M = class("HandbookMonsterdataEvaluateTipsView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._btnClose = self:getBtn("1&middle_tips_common_bg_-1205189576")
	self._btnCancel = self:getBtn("handbook_mosterdata_evaluate_tips_-1508450031")
	self._btnConfirm = self:getBtn("handbook_mosterdata_evaluate_tips_-337946340")
	self._txtName = self:getText("handbook_mosterdata_evaluate_tips_773165416")
	self._imgLiHui = self:getImage("handbook_mosterdata_evaluate_tips_-1316755856")
	self._imgDynIconLiHui = Astral.ImageDynIcon.Get(self._imgLiHui.gameObject)
	self._rawImg = self:getUIComponent("handbook_mosterdata_evaluate_tips_1104153716", UIComponentType.RawImage)
	self._photoUnit = Astral.LuaComponentContainer.Add(self._rawImg.gameObject, PhotoMultiModel)

	self._photoUnit:setDefaultAnim(UnitAnimState.Idle2)
	self._photoUnit:setModelsLoadedCallback(self._onModelsLoaded, self)
	self._photoUnit:enableTouch(nil, Handler.New(self._onBeginDragModel, self), Handler.New(self._onDragModel, self), Handler.New(self._onEndDragModel, self))

	self._starGroup = {}

	local starRoot = self:getUIComponent("handbook_mosterdata_evaluate_tips_2140685414", UIComponentType.RectTransform)

	for i = 0, starRoot.childCount - 1 do
		local index = i + 1
		local tr = starRoot:GetChild(i)

		self._starGroup[index] = {
			go = tr:GetChild(0).gameObject,
			btn = UIComponentType.ButtonAdapter(tr.gameObject)
		}
	end

	self._tagsRoot = self:getUIComponent("handbook_mosterdata_evaluate_tips_147051096", UIComponentType.RectTransform)
	self._tagItems = {}

	table.insert(self._tagItems, self:getGo("handbook_mosterdata_evaluate_tips_408608207"))
	table.insert(self._tagItems, self:getGo("handbook_mosterdata_evaluate_tips_-642151017"))
	table.insert(self._tagItems, self:getGo("handbook_mosterdata_evaluate_tips_-691787775"))
	table.insert(self._tagItems, self:getGo("handbook_mosterdata_evaluate_tips_-2096868856"))

	for _, go in ipairs(self._tagItems) do
		goutil.setActive(go, false)
	end
end

function M:destroyUI()
	self._btnClose = nil
	self._btnCancel = nil
	self._btnConfirm = nil
	self._txtName = nil
	self._rawImg = nil
	self._photoUnit = nil
	self._starGroup = nil
	self._tagsRoot = nil

	self:_clearItem()
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnCancel:AddClickListener(self._onClickClose, self)
	self._btnConfirm:AddClickListener(self._onClickConfirm, self)

	for index, value in ipairs(self._starGroup) do
		value.btn:AddClickListener(function()
			self:_onClickStar(index)
		end, self)
	end
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
	self._btnConfirm:RemoveClickListener()

	for index, value in ipairs(self._starGroup) do
		value.btn:RemoveClickListener()
	end

	for key, value in pairs(self._tagsGroup) do
		value.btn:RemoveClickListener()
	end
end

function M:onEnter()
	self._maxTagSelectCount = HandbookConfig.instance:getConst("CommentTagLimit").numValue
	self._curSelectCount = nil

	local info = self:getFirstParam()

	self._monsterId = info.monsterId
	self._myTags = {}

	local defaultStar = 3
	local mo = GalleryModel.instance:getMonsterComment(self._monsterId)

	if mo then
		if mo:getMyStar() > 0 then
			defaultStar = mo:getMyStar()
		end

		for _, tagId in ipairs(mo:getMyTags()) do
			self._myTags[tagId] = 1
		end
	end

	self:_onClickStar(defaultStar)
	self:refreshBase()
	self:refreshEvalutate()
end

function M:onExit()
	if self._photoUnit then
		self._photoUnit:clear()
	end

	self._imgDynIconLiHui:ClearImage()
end

function M:getMonsterId()
	return self._monsterId
end

function M:_onClickClose()
	self:close()
end

function M:_onClickConfirm()
	local dataChange = false
	local monsterId = self:getMonsterId()
	local myTagSelect = {}

	for _, tG in pairs(self._tagsGroup) do
		local tagId = tG.tagId
		local isSelected = tG.isSelected

		if isSelected then
			table.insert(myTagSelect, tagId)
		end

		if isSelected and self._myTags[tagId] == nil then
			dataChange = true
		end

		if not isSelected and self._myTags[tagId] then
			dataChange = true
		end
	end

	GalleryAgent.instance:sendCommitMonsterCommentRequest(monsterId, self._selectStar, myTagSelect)
	self:close()
end

function M:_onClickStar(starIndex)
	self._selectStar = starIndex

	self:refreshStar()
end

function M:_onClickTag(tagIndex)
	if not self._curSelectCount then
		local count = 0

		for _, value in pairs(self._tagsGroup) do
			count = value.isSelected and count + 1 or count
		end

		self._curSelectCount = count
	end

	local data = self._tagsGroup[tagIndex]
	local selected = not data.isSelected
	local preCurSelectCount = self._curSelectCount

	preCurSelectCount = selected and preCurSelectCount + 1 or preCurSelectCount - 1

	if preCurSelectCount > self._maxTagSelectCount then
		FloatWordMgr.instance:show(string.format(lang("tip_handbook_monster_evaluate_1"), self._maxTagSelectCount))

		return
	end

	data.isSelected = selected

	goutil.setActive(data.goNormal, not data.isSelected)
	goutil.setActive(data.goSelect, data.isSelected)

	self._curSelectCount = preCurSelectCount
end

function M:refreshBase()
	local id = self:getMonsterId()
	local cfg = HandbookConfig.instance:getConfigByKey(ConfigName.GalleryMonster, id)
	local cfgMonster = MonsterConfig.instance:getMonsterCO(id)
	local name = cfgMonster and cfgMonster.name or nil
	local modelId = cfgMonster and cfgMonster.modelId or nil

	self._txtName.text = name

	goutil.setActive(self._rawImg.gameObject, false)
	goutil.setActive(self._imgLiHui.gameObject, false)

	if modelId then
		local modelCO = ModelConfig.instance:getModelConfig(modelId)

		if cfg.showLiHui > 0 then
			goutil.setActive(self._rawImg.gameObject, false)

			local lihui = modelCO and modelCO.wholeIconName or nil

			if not string.nilorempty(lihui) then
				local setting = IconType.getSetting(IconType.CharaterIcon)

				self._imgDynIconLiHui:SetImage(string.format(setting.url, lihui), function()
					self._imgLiHui:SetNativeSize()
				end, self)
				goutil.setActive(self._imgLiHui.gameObject, true)
			else
				printWarn(string.format("怪物[%s] modelId[%s],不显示立绘,wholeIconName为空", id, modelId))
			end
		else
			RawImageUtil.SetColor(self._rawImg, "#FFFFFF00")
			goutil.setActive(self._rawImg.gameObject, true)

			local clipCO = CutImageConfig.instance:getClipCO(modelId)
			local posInfo = clipCO:getModelClipInfoArr("bustPosInfo")

			self._photoUnit:setContainerPosInfos({
				posInfo
			})
			self._photoUnit:showModels({
				GameUrl.getHighMeshModelUrl(modelCO.resName)
			})
			self._rawImg:DOFade(1, 0.5)
		end
	else
		printWarn(string.format("怪物[%s] modelId[%s],不显示立绘", id, modelId))
		self._photoUnit:clear()
		goutil.setActive(self._rawImg.gameObject, false)
	end
end

function M:refreshStar()
	local starNum = self._selectStar

	for index, starG in ipairs(self._starGroup) do
		local show = index <= starNum

		goutil.setActive(starG.go, show)
	end
end

function M:refreshEvalutate()
	local id = self:getMonsterId()
	local cfg = HandbookConfig.instance:getConfigByKey(ConfigName.GalleryMonster, id)
	local tagIds = cfg and cfg.tags or {}

	table.sort(tagIds, self.sortMonsterTag)
	self:_clearItem()

	if #tagIds > 0 then
		for index, tagId in ipairs(tagIds) do
			local cfgTag = HandbookConfig.instance:getConfigByKey(ConfigName.GalleryCommentTag, tagId)

			if cfgTag then
				local comps = self:_createItem(index, cfgTag.typ, tagId)
				local isSelected = self._myTags[tagId]

				comps.isSelected = isSelected
				comps.txtName1.text = cfgTag.content
				comps.txtName2.text = cfgTag.content

				goutil.setActive(comps.goNormal, not isSelected)
				goutil.setActive(comps.goSelect, isSelected)
				goutil.setActive(comps.go, true)
			end
		end
	end
end

function M:_clearItem()
	for _, value in pairs(self._tagsGroup or {}) do
		if value.btn then
			value.btn:RemoveClickListener()
		end

		goutil.destroy(value.go)
	end

	self._tagsGroup = nil
end

function M:_createItem(index, typ, tagId)
	if not self._tagsGroup then
		self._tagsGroup = {}
	end

	local goPrefabItem = self._tagItems[typ]

	if goPrefabItem then
		local go = goutil.cloneAndSetParent(goPrefabItem, self._tagsRoot)
		local comps = {}

		comps.go = go
		comps.index = index
		comps.tagId = tagId
		comps.isSelected = false
		comps.goNormal = goutil.findChild(go, "normal")
		comps.goSelect = goutil.findChild(go, "select")
		comps.txtName1 = goutil.findChildTextComponent(go, "normal/Text")
		comps.txtName2 = goutil.findChildTextComponent(go, "select/Text")
		comps.btn = UIComponentType.ButtonAdapter(go)

		comps.btn:AddClickListener(function()
			self:_onClickTag(index)
		end)

		self._tagsGroup[index] = comps

		return comps
	else
		printError(string.format("无法找到[%s]类型标签预制体", typ))

		return nil
	end
end

function M.sortMonsterTag(tagId1, tagId2)
	local ascending = false
	local cfgTagA = HandbookConfig.instance:getConfigByKey(ConfigName.GalleryCommentTag, tagId1)
	local cfgTagB = HandbookConfig.instance:getConfigByKey(ConfigName.GalleryCommentTag, tagId2)

	if not cfgTagA or not cfgTagB then
		return false
	end

	if cfgTagA.typ == cfgTagB.typ then
		if ascending then
			return cfgTagA.id < cfgTagB.id
		else
			return cfgTagB.id < cfgTagA.id
		end
	end

	if ascending then
		return cfgTagA.typ < cfgTagB.typ
	else
		return cfgTagB.typ < cfgTagA.typ
	end
end

function M:_onBeginDragModel(posX, posY, pointerId)
	self._lastPosX = posX
end

function M:_onDragModel(posX, posY, pointerId)
	local deltaX = posX - self._lastPosX

	self:_rotaModel(deltaX)

	self._lastPosX = posX
end

function M:_onEndDragModel(posX, posY, pointerId)
	return
end

function M:_rotaModel(deltaX)
	local _, rotaY, _ = self._photoUnit:getContainerRotation(1)
	local rotationY = rotaY + -deltaX

	self._photoUnit:setContainerRotationY(1, rotationY)
end

function M:_onModelsLoaded()
	self._photoUnit:showUIReflection()
	self._photoUnit:setCameraCullingMask(Astral.LayerUtil.GetLayerMask(SceneLayer.UI3D, SceneLayer.Unit))
	self._photoUnit:setCameraTag(SceneTag.RTCamera)
end

return M
