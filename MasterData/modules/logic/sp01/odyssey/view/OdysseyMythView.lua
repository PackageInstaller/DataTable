-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyMythView.lua

module("modules.logic.sp01.odyssey.view.OdysseyMythView", package.seeall)

local OdysseyMythView = class("OdysseyMythView", BaseView)

function OdysseyMythView:onInitView()
	self._goBossContent = gohelper.findChild(self.viewGO, "root/#go_BossContent")
	self._gobossItem = gohelper.findChild(self.viewGO, "root/#go_BossContent/#go_bossItem")
	self._gotopleft = gohelper.findChild(self.viewGO, "root/#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function OdysseyMythView:addEvents()
	return
end

function OdysseyMythView:removeEvents()
	return
end

function OdysseyMythView:_btnMythItemOnClick(mythItem)
	local elementId = mythItem.config.elementId
	local mythElementMo = OdysseyDungeonModel.instance:getElementMo(elementId)

	if not mythElementMo then
		GameFacade.showToast(ToastEnum.OdysseyMythLock)

		return
	end

	OdysseyDungeonController.instance:jumpToMapElement(elementId)
	self:closeThis()
end

function OdysseyMythView:_editableInitView()
	self.mythItemMap = self:getUserDataTb_()

	gohelper.setActive(self._gobossItem, false)
end

function OdysseyMythView:onUpdateParam()
	return
end

function OdysseyMythView:onOpen()
	self:refreshUI()
	self:playUnlockEffect()
end

function OdysseyMythView:refreshUI()
	self.mythConfigList = OdysseyConfig.instance:getMythConfigList()

	for _, mythConfig in ipairs(self.mythConfigList) do
		local mythItem = self.mythItemMap[mythConfig.id]

		if not mythItem then
			mythItem = {
				config = mythConfig,
				go = gohelper.clone(self._gobossItem, self._goBossContent)
			}
			mythItem.lock = gohelper.findChild(mythItem.go, "lock")
			mythItem.unlock = gohelper.findChild(mythItem.go, "unlock")
			mythItem.simageBoss = gohelper.findChildSingleImage(mythItem.go, "unlock/simage_boss")
			mythItem.imageBoss = gohelper.findChildImage(mythItem.go, "unlock/simage_boss")
			mythItem.txtName = gohelper.findChildText(mythItem.go, "unlock/txt_bossName")
			mythItem.golevel = gohelper.findChild(mythItem.go, "unlock/go_level")
			mythItem.simageLevel = gohelper.findChildSingleImage(mythItem.go, "unlock/go_level/simage_level")
			mythItem.imageRecord = gohelper.findChildImage(mythItem.go, "unlock/go_level/image_record")
			mythItem.imageRecordGlow = gohelper.findChildImage(mythItem.go, "unlock/go_level/image_record_glow")
			mythItem.btnClick = gohelper.findChildButtonWithAudio(mythItem.go, "btn_click")

			mythItem.btnClick:AddClickListener(self._btnMythItemOnClick, self, mythItem)

			mythItem.frameEffectGOMap = {}

			for evaluation = 1, 3 do
				mythItem.frameEffectGOMap[evaluation] = gohelper.findChild(mythItem.go, "unlock/go_level/vx_glow/" .. evaluation)
			end

			mythItem.material = mythItem.imageBoss.material
			mythItem.imageBoss.material = UnityEngine.Object.Instantiate(mythItem.material)
			mythItem.materialPropsCtrl = mythItem.go:GetComponent(typeof(ZProj.MaterialPropsCtrl))

			mythItem.materialPropsCtrl.mas:Clear()
			mythItem.materialPropsCtrl.mas:Add(mythItem.imageBoss.material)

			mythItem.anim = mythItem.go:GetComponent(gohelper.Type_Animator)
			self.mythItemMap[mythConfig.id] = mythItem
		end

		gohelper.setActive(mythItem.go, true)

		local mythElementMo = OdysseyDungeonModel.instance:getElementMo(mythConfig.elementId)

		gohelper.setActive(mythItem.lock, not mythElementMo)
		gohelper.setActive(mythItem.unlock, mythElementMo)

		if mythElementMo then
			mythItem.simageBoss:LoadImage(ResUrl.getSp01OdysseySingleBg(mythConfig.res))

			mythItem.txtName.text = mythConfig.name

			local recordData = mythElementMo:getMythicEleData()

			gohelper.setActive(mythItem.golevel, recordData and recordData.evaluation > 0)

			if recordData and recordData.evaluation > 0 then
				UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(mythItem.imageRecord, "pingji_d_" .. recordData.evaluation)
				UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(mythItem.imageRecordGlow, "pingji_d_" .. recordData.evaluation)
				mythItem.simageLevel:LoadImage(ResUrl.getSp01OdysseySingleBg("mythcreatures/odyssey_mythcreatures_level_" .. recordData.evaluation))

				for index, frameEffectGO in pairs(mythItem.frameEffectGOMap) do
					gohelper.setActive(frameEffectGO, index == recordData.evaluation)
				end
			end
		end
	end
end

function OdysseyMythView:playUnlockEffect()
	local curUnlockMythIdList = OdysseyDungeonModel.instance:getCurUnlockMythIdList()
	local hasNewUnlock, newUnlockIdList = OdysseyDungeonModel.instance:checkHasNewUnlock(OdysseyEnum.LocalSaveKey.MythNew, curUnlockMythIdList)

	if hasNewUnlock then
		for index, mythId in pairs(newUnlockIdList) do
			local mythItem = self.mythItemMap[mythId]

			if mythItem then
				gohelper.setActive(mythItem.lock, true)
				mythItem.anim:Play("unlock", 0, 0)
				mythItem.anim:Update(0)
			end
		end
	end
end

function OdysseyMythView:onClose()
	for index, mythItem in pairs(self.mythItemMap) do
		mythItem.btnClick:RemoveClickListener()
		mythItem.simageBoss:UnLoadImage()
		mythItem.simageLevel:UnLoadImage()
	end

	OdysseyDungeonModel.instance:saveLocalCurNewLock(OdysseyEnum.LocalSaveKey.MythNew, OdysseyDungeonModel.instance:getCurUnlockMythIdList())
	OdysseyController.instance:dispatchEvent(OdysseyEvent.OnRefreshReddot)
end

function OdysseyMythView:onDestroyView()
	return
end

return OdysseyMythView
