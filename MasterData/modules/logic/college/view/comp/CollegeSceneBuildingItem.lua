-- chunkname: @modules/logic/college/view/comp/CollegeSceneBuildingItem.lua

module("modules.logic.college.view.comp.CollegeSceneBuildingItem", package.seeall)

local CollegeSceneBuildingItem = class("CollegeSceneBuildingItem", CollegeSceneBaseItem)
local clickPos = {
	[4010004] = {
		width = 500.7,
		height = 639,
		y = -312.3,
		x = 59.6,
		rotation = Vector3(55.3, -3, 11.3)
	},
	[4010005] = {
		width = 567.43,
		height = 574.8,
		y = -241.5,
		x = 60.8,
		rotation = Vector3(60.9, -17.7, 1.8)
	}
}

function CollegeSceneBuildingItem:onInitView()
	self.goheroItems = gohelper.findChild(self.root, "#go_items")
	self.heroItems = gohelper.findChild(self.root, "#go_items/#go_heroItem")
	self._txtname = gohelper.findChildTextMesh(self.root, "bg/#txt_name")
	self._imageLv = gohelper.findChildImage(self.root, "bg/#txt_name/#image_level")
	self._gobuild = gohelper.findChild(self.root, "#go_build")
	self._gounlock = gohelper.findChild(self.root, "#go_unlock")
	self._btnClick = gohelper.findChildButtonWithAudio(self.root, "#btn_click")
	self._goRes = gohelper.findChild(self.root, "#go_resbg")
	self._txtRes = gohelper.findChildTextMesh(self.root, "#go_resbg/#txt_res")
	self._iconRes = gohelper.findChildImage(self.root, "#go_resbg/#txt_res/icon")
	self._gocanrefine = gohelper.findChild(self.root, "#go_canrefine")
	self._gocanrecruitment = gohelper.findChild(self.root, "#go_canrecruitment")
	self._gocanuplv = gohelper.findChild(self.root, "bg/#txt_name/#go_canuplv")
	self._animbuild = self._gobuild:GetComponent(typeof(UnityEngine.Animation))

	self.addClickCb(self, self._btnClick, self.onClick, self)
end

function CollegeSceneBuildingItem:addEventListeners()
	CollegeSceneBuildingItem.super.addEventListeners(self)
	CollegeController.instance:registerCallback(CollegeEvent.UpdateBuilding, self.updateData, self)
	CollegeController.instance:registerCallback(CollegeEvent.UpdateBag, self.updateBag, self)
	CollegeController.instance:registerCallback(CollegeEvent.OnFocusEnd, self.onFocusEnd, self)
	CollegeController.instance:registerCallback(CollegeEvent.OnFocusCancel, self.onFocusCancel, self)
	CollegeController.instance:registerCallback(CollegeEvent.PlayBuildingUpgradeAnim, self.playBuildingUpgradeAnim, self)
end

function CollegeSceneBuildingItem:removeEventListeners()
	CollegeSceneBuildingItem.super.removeEventListeners(self)
	CollegeController.instance:unregisterCallback(CollegeEvent.UpdateBuilding, self.updateData, self)
	CollegeController.instance:unregisterCallback(CollegeEvent.UpdateBag, self.updateBag, self)
	CollegeController.instance:unregisterCallback(CollegeEvent.OnFocusEnd, self.onFocusEnd, self)
	CollegeController.instance:unregisterCallback(CollegeEvent.OnFocusCancel, self.onFocusCancel, self)
	CollegeController.instance:unregisterCallback(CollegeEvent.PlayBuildingUpgradeAnim, self.playBuildingUpgradeAnim, self)
end

function CollegeSceneBuildingItem:updateData(data)
	data = data or self.data

	CollegeSceneBuildingItem.super.updateData(self, data)
	gohelper.setActive(self.root, data.unlock)
	gohelper.setActive(self.arrow, data.unlock)
	self:loadBuildingAsset()

	if not data.unlock then
		return
	end

	self:setUITrans()
	self:_refreshHero()
	self:_refreshRes()
	self:updateBag()

	self._txtname.text = data.co.name

	CollegeIconHelper.setBuildingLv(self._imageLv, data.level)
	gohelper.setActive(self._gobuild, data.level == 0)
	gohelper.setActive(self._gounlock, data.level > 0)
	self:refreshBuildingShow()
end

function CollegeSceneBuildingItem:setUITrans()
	if not self.ui or not self.data then
		return
	end

	if self._isSetUITrans then
		return
	end

	self._isSetUITrans = true

	local rotateStr = self.data.co.rotation

	if not string.nilorempty(rotateStr) then
		local arr = string.splitToNumber(rotateStr, "#")

		transformhelper.setLocalRotation(self.root.transform, arr[1] or 0, arr[2] or 0, arr[3] or 0)
	end

	local clickTrans = self._btnClick.transform

	transformhelper.setRotation(clickTrans, 0, 0, 0, 1)

	local offsetStr = self.data.co.posOffset

	if not string.nilorempty(offsetStr) then
		local arr = string.splitToNumber(offsetStr, "#")

		if self._uiFollower then
			self._uiFollower:SetOffset2d(arr[1] or 0, arr[2] or 0)
		end

		if self._uiFollower2 then
			self._uiFollower2:SetOffset2d(arr[1] or 0, arr[2] or 0)
		end
	end

	local clickPosData = clickPos[self.data.id]

	if clickPosData then
		local btnTrans = self._btnClick.transform

		transformhelper.setLocalRotation(btnTrans, clickPosData.rotation.x, clickPosData.rotation.y, clickPosData.rotation.z, clickPosData.rotation.w)
		recthelper.setAnchor(btnTrans, clickPosData.x, clickPosData.y)
		recthelper.setSize(btnTrans, clickPosData.width, clickPosData.height)
	end
end

function CollegeSceneBuildingItem:loadBuildingAsset()
	self.loader = PrefabInstantiate.Create(self.go)

	local assetPath = self.data.co.assetPath

	if not string.nilorempty(assetPath) then
		assetPath = string.format("modules/college/scene/prefab/%s.prefab", assetPath)
	end

	if self.loader:getPath() ~= assetPath then
		self.loader:dispose()

		if not string.nilorempty(assetPath) then
			self.loader:startLoad(assetPath, self._onLoadedRes, self)
		end
	end
end

function CollegeSceneBuildingItem:_onLoadedRes()
	if not self.loader then
		return
	end

	local go = self.loader:getInstGO()

	if not go then
		return
	end

	self._lvDict = {}

	local trans = go.transform
	local pos = self.data.pos

	transformhelper.setLocalPos(trans, -pos.x, -pos.y, -pos.z)
	self:processTrans(trans)
	self:refreshBuildingShow()

	self._anim = gohelper.findComponentAnim(go)
	self._gojob = gohelper.findChild(go, "job")

	self:playAnim("zoom_out", 1)
	self:refreshJobShow()
end

function CollegeSceneBuildingItem:onEnable()
	self:playAnim("zoom_out", 1)
end

function CollegeSceneBuildingItem:onFocusEnd()
	self:playAnim("zoom_in")
end

function CollegeSceneBuildingItem:onFocusCancel()
	self:playAnim("zoom_out")
end

function CollegeSceneBuildingItem:playBuildingUpgradeAnim(buildingId)
	if buildingId ~= self.data.id then
		return
	end

	if self.data.level <= 0 then
		CollegeAudioHelper.instance:playAudio(CollegeAudioEnum.BuildBuilding)
		self:playAnim("build")
	else
		CollegeAudioHelper.instance:playAudio(CollegeAudioEnum.UpgradeBuilding)
		self:playAnim("leveup")
	end
end

function CollegeSceneBuildingItem:refreshJobShow()
	local haveSlot = self.data.slotCharacterUid and #self.data.slotCharacterUid > 0 or false

	gohelper.setActive(self._gojob, haveSlot)
end

function CollegeSceneBuildingItem:playAnim(animName, time)
	if self._anim then
		self._anim:Play(animName, 0, time or 0)
	end
end

function CollegeSceneBuildingItem:processTrans(trans)
	for i = 0, trans.childCount - 1 do
		local child = trans:GetChild(i)
		local lv = tonumber(child.name)

		if lv then
			self._lvDict[lv] = self._lvDict[lv] or self:getUserDataTb_()

			table.insert(self._lvDict[lv], child.gameObject)
		else
			self:processTrans(child)
		end
	end
end

function CollegeSceneBuildingItem:refreshBuildingShow()
	if self.data.lvCo then
		if not self.data.lvCo.buildingAsset then
			local showNode = 1

			if self._lvDict then
				for k, v in pairs(self._lvDict) do
					for i, go in ipairs(v) do
						gohelper.setActive(go, k == showNode)
					end
				end
			end
		end
	end
end

function CollegeSceneBuildingItem:onClick()
	CollegeHelper.instance:focusTo(self.data, self.finishCallback, self)
end

function CollegeSceneBuildingItem:finishCallback()
	ViewMgr.instance:openView(ViewName.CollegeBuildingView, {
		data = self.data
	})
end

function CollegeSceneBuildingItem:_refreshHero()
	local datas = {}
	local sceneMo = CollegeModel.instance:getSceneMo()
	local maxSlotNum = CollegeConfig.instance:getBuildingSlotInfo(self.data.id).maxSlotNum

	if self.data.level <= 0 then
		maxSlotNum = 0
	end

	local slotNum = self.data.slotNum

	for i = 1, maxSlotNum do
		datas[i] = i <= slotNum and (sceneMo.characterBox:getCharacterMo(self.data.slotCharacterUid[i]) or 1) or 2
	end

	gohelper.setActive(self.goheroItems, maxSlotNum > 0)
	gohelper.CreateObjList(self, self._createHero, datas, nil, self.heroItems)
	self:refreshJobShow()
end

function CollegeSceneBuildingItem:_createHero(obj, data, index)
	local simageHero = gohelper.findChildSingleImage(obj, "#simage_hero")
	local goadd = gohelper.findChild(obj, "#go_add")
	local golock = gohelper.findChild(obj, "#go_lock")

	gohelper.setActive(simageHero, type(data) == "table")
	gohelper.setActive(goadd, data == 1)
	gohelper.setActive(golock, data == 2)

	if type(data) == "table" then
		simageHero:LoadImage(ResUrl.getCollegeSingleBg(data.co.avatar, "headicon_small"))
	end
end

function CollegeSceneBuildingItem:_refreshRes()
	local itemId, val = self.data:getCurProduceItem()

	if itemId then
		gohelper.setActive(self._goRes, true)

		self._txtRes.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("college_res_produce"), val)

		CollegeIconHelper.setItemIcon(itemId, self._iconRes)
	else
		gohelper.setActive(self._goRes, false)
	end
end

function CollegeSceneBuildingItem:updateBag()
	self:_refreshCanRefine()
	self:_refreshCanRecruitment()
	self:_refreshCanUplv()
end

function CollegeSceneBuildingItem:_refreshCanRefine()
	if self.data.level <= 0 or self.data.co.buildingType ~= CollegeEnum.BuildingType.TrainCharacter then
		gohelper.setActive(self._gocanrefine, false)
	else
		gohelper.setActive(self._gocanrefine, CollegeModel.instance:isEnoughItemsTb(CollegeAttrHelper.getRefineCostAndRate()))
	end
end

function CollegeSceneBuildingItem:_refreshCanRecruitment()
	if self.data.level <= 0 or self.data.co.buildingType ~= CollegeEnum.BuildingType.RecruitCharacter then
		gohelper.setActive(self._gocanrecruitment, false)
	else
		gohelper.setActive(self._gocanrecruitment, CollegeModel.instance:isEnoughItemsTb(CollegeAttrHelper.getRecruitCostAndRate()))
	end
end

function CollegeSceneBuildingItem:_refreshCanUplv()
	if self.data.level <= 0 or not self.data.nextLvCo then
		gohelper.setActive(self._gocanuplv, false)
	else
		gohelper.setActive(self._gocanuplv, CollegeModel.instance:isEnoughItems(self.data.nextLvCo.upgradeCost))
	end

	if self.data.unlock and self.data.level == 0 and self.data.nextLvCo then
		local canBuild = CollegeModel.instance:isEnoughItems(self.data.nextLvCo.upgradeCost)

		if self._animbuild then
			self._animbuild.enabled = canBuild

			if not canBuild then
				transformhelper.setLocalRotation(self._gobuild.transform, 0, 0, 0)
			end
		end
	end
end

function CollegeSceneBuildingItem:onDestroy()
	if self.loader then
		self.loader:dispose()

		self.loader = nil
	end

	CollegeSceneBuildingItem.super.onDestroy(self)
end

return CollegeSceneBuildingItem
