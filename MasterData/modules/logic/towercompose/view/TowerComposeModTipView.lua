-- chunkname: @modules/logic/towercompose/view/TowerComposeModTipView.lua

module("modules.logic.towercompose.view.TowerComposeModTipView", package.seeall)

local TowerComposeModTipView = class("TowerComposeModTipView", BaseView)

function TowerComposeModTipView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._goRoot = gohelper.findChild(self.viewGO, "root")
	self._gobodyModContent = gohelper.findChild(self.viewGO, "root/#go_bodyModContent")
	self._gobodyModItem = gohelper.findChild(self.viewGO, "root/#go_bodyModContent/#go_bodyModItem")
	self._gowordModContent = gohelper.findChild(self.viewGO, "root/#go_wordModContent")
	self._gowordModItem = gohelper.findChild(self.viewGO, "root/#go_wordModContent/#go_wordModItem")
	self._goenvContent = gohelper.findChild(self.viewGO, "root/#go_envContent")
	self._goenvModItem = gohelper.findChild(self.viewGO, "root/#go_envContent/#go_envModItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerComposeModTipView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function TowerComposeModTipView:removeEvents()
	self._btnclose:RemoveClickListener()
end

TowerComposeModTipView.normalWidth = 1218

function TowerComposeModTipView:_btncloseOnClick()
	self:closeThis()
end

function TowerComposeModTipView:_editableInitView()
	self.bodyModItemList = self:getUserDataTb_()
	self.wordModItemList = self:getUserDataTb_()
	self.envModItemList = self:getUserDataTb_()
	self._goRoot = gohelper.findChild(self.viewGO, "root")

	gohelper.setActive(self._gobodyModItem, false)
	gohelper.setActive(self._gowordModItem, false)
	gohelper.setActive(self._goenvModItem, false)
end

function TowerComposeModTipView:onUpdateParam()
	return
end

function TowerComposeModTipView:onOpen()
	self.themeId = self.viewParam.themeId
	self.planeId = self.viewParam.planeId
	self.modType = self.viewParam.modType
	self.offsetPos = self.viewParam.offsetPos or {
		0,
		0
	}

	recthelper.setAnchor(self._goRoot.transform, self.offsetPos[1], self.offsetPos[2])
	self:refreshUI()
end

function TowerComposeModTipView:refreshUI()
	self.themeMo = TowerComposeModel.instance:getThemeMo(self.themeId)
	self.planeMo = self.themeMo:getPlaneMo(self.planeId)

	gohelper.setActive(self._gobodyModContent, self.modType == TowerComposeEnum.ModType.Body)
	gohelper.setActive(self._gowordModContent, self.modType == TowerComposeEnum.ModType.Word)
	gohelper.setActive(self._goenvContent, self.modType == TowerComposeEnum.ModType.Env)

	if self.modType == TowerComposeEnum.ModType.Body then
		self:refreshBodyModList()
	elseif self.modType == TowerComposeEnum.ModType.Word then
		self:refreshWordModList()
	elseif self.modType == TowerComposeEnum.ModType.Env then
		self:refreshEnvModList()
	end
end

function TowerComposeModTipView:refreshBodyModList()
	self.modInfoList = self.planeMo:getHaveModInfoList(self.modType)

	for index, modData in ipairs(self.modInfoList) do
		local bodyModItem = self.bodyModItemList[index]

		if not bodyModItem then
			bodyModItem = {
				config = TowerComposeConfig.instance:getComposeModConfig(modData.modId)
			}
			bodyModItem.go = gohelper.clone(self._gobodyModItem, self._gobodyModContent, "modItem" .. bodyModItem.config.id)
			bodyModItem.goBg1 = gohelper.findChild(bodyModItem.go, "go_bg1")
			bodyModItem.goBg2 = gohelper.findChild(bodyModItem.go, "go_bg2")
			bodyModItem.imageIcon = gohelper.findChildImage(bodyModItem.go, "image_icon")
			bodyModItem.imageModColorIcon = gohelper.findChildImage(bodyModItem.go, "image_icon_01")
			bodyModItem.materialModIcon = UnityEngine.Object.Instantiate(bodyModItem.imageModColorIcon.material)
			bodyModItem.imageModLvColorIcon = gohelper.findChildImage(bodyModItem.go, "image_icon_02")
			bodyModItem.materialModLvIcon = UnityEngine.Object.Instantiate(bodyModItem.imageModLvColorIcon.material)
			bodyModItem.imageModColorIcon.material = bodyModItem.materialModIcon
			bodyModItem.imageModLvColorIcon.material = bodyModItem.materialModLvIcon
			bodyModItem.txtDesc = gohelper.findChildText(bodyModItem.go, "txt_desc")
			bodyModItem.descFixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(bodyModItem.txtDesc.gameObject, FixTmpBreakLine)

			SkillHelper.addHyperLinkClick(bodyModItem.txtDesc, self._onHyperLinkClick, self)

			bodyModItem.txtName = gohelper.findChildText(bodyModItem.go, "txt_desc/txt_name")
			bodyModItem.txtLv = gohelper.findChildText(bodyModItem.go, "txt_desc/txt_name/txt_lv")
			bodyModItem.modIconComp = MonoHelper.addNoUpdateLuaComOnceToGo(bodyModItem.go, TowerComposeModIconComp)
			self.bodyModItemList[index] = bodyModItem
		end

		gohelper.setActive(bodyModItem.go, true)
		gohelper.setActive(bodyModItem.goBg1, self.planeId == 1)
		gohelper.setActive(bodyModItem.goBg2, self.planeId == 2)
		bodyModItem.modIconComp:refreshMod(bodyModItem.config.id, bodyModItem.imageIcon, bodyModItem.imageModColorIcon, bodyModItem.imageModLvColorIcon, bodyModItem.materialModIcon, bodyModItem.materialModLvIcon)

		bodyModItem.txtDesc.text = SkillHelper.buildDesc(bodyModItem.config.desc)
		bodyModItem.txtName.text = bodyModItem.config.name
		bodyModItem.txtLv.text = string.format("Lv.%d", bodyModItem.config.level)
	end
end

function TowerComposeModTipView:refreshWordModList()
	self.modInfoList = self.planeMo:getHaveModInfoList(self.modType)

	recthelper.setWidth(self._goRoot.transform, (#self.modInfoList < 2 or nil) and (TowerComposeModTipView.normalWidth / 2 or TowerComposeModTipView.normalWidth))
	recthelper.setWidth(self._gowordModContent.transform, (#self.modInfoList < 2 or nil) and (TowerComposeModTipView.normalWidth / 2 or TowerComposeModTipView.normalWidth))

	for index, modData in ipairs(self.modInfoList) do
		local wordModItem = self.wordModItemList[index]

		if not wordModItem then
			wordModItem = {
				config = TowerComposeConfig.instance:getComposeModConfig(modData.modId)
			}
			wordModItem.go = gohelper.clone(self._gowordModItem, self._gowordModContent, "modItem" .. wordModItem.config.id)
			wordModItem.goBg1 = gohelper.findChild(wordModItem.go, "go_bg1")
			wordModItem.goBg2 = gohelper.findChild(wordModItem.go, "go_bg2")
			wordModItem.imageIcon = gohelper.findChildImage(wordModItem.go, "image_icon")
			wordModItem.imageModColorIcon = gohelper.findChildImage(wordModItem.go, "image_icon_01")
			wordModItem.materialModIcon = UnityEngine.Object.Instantiate(wordModItem.imageModColorIcon.material)
			wordModItem.imageModLvColorIcon = gohelper.findChildImage(wordModItem.go, "image_icon_02")
			wordModItem.materialModLvIcon = UnityEngine.Object.Instantiate(wordModItem.imageModLvColorIcon.material)
			wordModItem.imageModColorIcon.material = wordModItem.materialModIcon
			wordModItem.imageModLvColorIcon.material = wordModItem.materialModLvIcon
			wordModItem.txtDesc = gohelper.findChildText(wordModItem.go, "txt_desc")
			wordModItem.descFixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(wordModItem.txtDesc.gameObject, FixTmpBreakLine)
			wordModItem.txtName = gohelper.findChildText(wordModItem.go, "txt_name")
			wordModItem.txtLv = gohelper.findChildText(wordModItem.go, "txt_name/txt_lv")

			SkillHelper.addHyperLinkClick(wordModItem.txtDesc, self._onHyperLinkClick, self)

			wordModItem.modIconComp = MonoHelper.addNoUpdateLuaComOnceToGo(wordModItem.go, TowerComposeModIconComp)
			self.wordModItemList[index] = wordModItem
		end

		gohelper.setActive(wordModItem.go, true)
		gohelper.setActive(wordModItem.goBg1, self.planeId == 1)
		gohelper.setActive(wordModItem.goBg2, self.planeId == 2)
		wordModItem.modIconComp:refreshMod(wordModItem.config.id, wordModItem.imageIcon, wordModItem.imageModColorIcon, wordModItem.imageModLvColorIcon, wordModItem.materialModIcon, wordModItem.materialModLvIcon)

		wordModItem.txtDesc.text = SkillHelper.buildDesc(wordModItem.config.desc)
		wordModItem.txtName.text = wordModItem.config.name
		wordModItem.txtLv.text = string.format("Lv.%d", wordModItem.config.level)
	end
end

function TowerComposeModTipView:refreshEnvModList()
	self.modInfoList = self.planeMo:getHaveModInfoList(self.modType)

	for index, modData in ipairs(self.modInfoList) do
		local envModItem = self.envModItemList[index]

		if not envModItem then
			envModItem = {
				config = TowerComposeConfig.instance:getComposeModConfig(modData.modId)
			}
			envModItem.go = gohelper.clone(self._goenvModItem, self._goenvContent, "modItem" .. envModItem.config.id)
			envModItem.goBg1 = gohelper.findChild(envModItem.go, "go_bg1")
			envModItem.goBg2 = gohelper.findChild(envModItem.go, "go_bg2")
			envModItem.simagePic = gohelper.findChildSingleImage(envModItem.go, "simage_pic")
			envModItem.imageIcon = gohelper.findChildImage(envModItem.go, "image_icon")
			envModItem.txtDesc = gohelper.findChildText(envModItem.go, "txt_desc")
			envModItem.descFixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(envModItem.txtDesc.gameObject, FixTmpBreakLine)
			envModItem.txtName = gohelper.findChildText(envModItem.go, "txt_name")
			envModItem.txtLv = gohelper.findChildText(envModItem.go, "txt_name/txt_lv")
			envModItem.goLine = gohelper.findChild(envModItem.go, "line")

			SkillHelper.addHyperLinkClick(envModItem.txtDesc, self._onHyperLinkClick, self)

			self.envModItemList[index] = envModItem
		end

		gohelper.setActive(envModItem.go, true)
		gohelper.setActive(envModItem.goBg1, self.planeId == 1)
		gohelper.setActive(envModItem.goBg2, self.planeId == 2)
		gohelper.setActive(envModItem.goLine, index < #self.modInfoList)
		UISpriteSetMgr.instance:setTower2Sprite(envModItem.imageIcon, envModItem.config.icon)
		envModItem.simagePic:LoadImage(envModItem.config.image)

		envModItem.txtDesc.text = SkillHelper.buildDesc(envModItem.config.desc)

		envModItem.descFixTmpBreakLine:refreshTmpContent(envModItem.txtDesc)

		envModItem.txtName.text = envModItem.config.name
		envModItem.txtLv.text = string.format("Lv.%d", envModItem.config.level)
	end
end

function TowerComposeModTipView:_onHyperLinkClick(effId, clickPosition)
	CommonBuffTipController.instance:openCommonTipView(tonumber(effId), clickPosition)
end

function TowerComposeModTipView:onClose()
	return
end

function TowerComposeModTipView:onDestroyView()
	return
end

return TowerComposeModTipView
