-- chunkname: @modules/logic/fight/view/FightTechniqueTipsView.lua

module("modules.logic.fight.view.FightTechniqueTipsView", package.seeall)

local FightTechniqueTipsView = class("FightTechniqueTipsView", BaseView)

FightTechniqueTipsView.TweenDuration = 0.25

function FightTechniqueTipsView:onInitView()
	self._goclose = gohelper.findChildClick(self.viewGO, "#go_close")
	self._txttemp = gohelper.findChildText(self.viewGO, "#txt_temp")
	self._mask = gohelper.findChildClickWithAudio(self.viewGO, "mask")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightTechniqueTipsView:addEvents()
	self._goclose:AddClickListener(self._btncloseOnClick, self)
	self._mask:AddClickListener(self.closeThis, self)
end

function FightTechniqueTipsView:removeEvents()
	self._goclose:RemoveClickListener()
	self._mask:RemoveClickListener()
end

function FightTechniqueTipsView:_btncloseOnClick()
	self:closeThis()
end

function FightTechniqueTipsView:_editableInitView()
	self.pointItemList = {}
	self.goPointList = gohelper.findChild(self.viewGO, "#go_pointlist")
	self.goCenter = gohelper.findChild(self.viewGO, "#go_center")
	self.simageicon = gohelper.findChildSingleImage(self.viewGO, "#go_center/#simage_icon")
	self.rectCenter = self.goCenter:GetComponent(gohelper.Type_RectTransform)
	self.centerWidth = recthelper.getWidth(self.rectCenter)
	self.goCenter1 = gohelper.cloneInPlace(self.goCenter, "center1")
	self.simageicon1 = gohelper.findChildSingleImage(self.goCenter1, "#simage_icon")
	self.rectCenter1 = self.goCenter1:GetComponent(gohelper.Type_RectTransform)

	gohelper.setSiblingAfter(self.goCenter1, self.goCenter)
	gohelper.setActive(self.goCenter1, false)

	self.goLeftBtn = gohelper.findChild(self.viewGO, "#btn_left")
	self.goRightBtn = gohelper.findChild(self.viewGO, "#btn_right")
	self.leftClick = gohelper.getClickWithDefaultAudio(self.goLeftBtn)
	self.rightClick = gohelper.getClickWithDefaultAudio(self.goRightBtn)

	self.leftClick:AddClickListener(self.onClickLeft, self)
	self.rightClick:AddClickListener(self.onClickRight, self)
end

function FightTechniqueTipsView:onClickLeft()
	if self.curIndex <= 1 then
		return
	end

	if self.tweenId then
		return
	end

	self.curIndex = self.curIndex - 1

	self:refreshCenter(self.goCenter1, self.simageicon1, self.configList[self.curIndex])
	recthelper.setAnchorX(self.rectCenter1, -self.centerWidth)
	gohelper.setActive(self.goCenter1, true)

	self.center1StartAnchorX = -self.centerWidth
	self.center1EndAnchorX = 0
	self.centerStartAnchorX = 0
	self.centerEndAnchorX = self.centerWidth
	self.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, FightTechniqueTipsView.TweenDuration, self.tweenFrameCallback, self.tweenDoneCallback, self)

	self:refreshPoint()
	self:refreshBtnState()
end

function FightTechniqueTipsView:onClickRight()
	if self.curIndex >= self.configCount then
		return
	end

	if self.tweenId then
		return
	end

	self.curIndex = self.curIndex + 1

	self:refreshCenter(self.goCenter1, self.simageicon1, self.configList[self.curIndex])
	recthelper.setAnchorX(self.rectCenter1, self.centerWidth)
	gohelper.setActive(self.goCenter1, true)

	self.center1StartAnchorX = self.centerWidth
	self.center1EndAnchorX = 0
	self.centerStartAnchorX = 0
	self.centerEndAnchorX = -self.centerWidth
	self.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, FightTechniqueTipsView.TweenDuration, self.tweenFrameCallback, self.tweenDoneCallback, self)

	self:refreshPoint()
	self:refreshBtnState()
end

function FightTechniqueTipsView:tweenFrameCallback(value)
	local centerAnchor = Mathf.Lerp(self.centerStartAnchorX, self.centerEndAnchorX, value)
	local center1Anchor = Mathf.Lerp(self.center1StartAnchorX, self.center1EndAnchorX, value)

	recthelper.setAnchorX(self.rectCenter, centerAnchor)
	recthelper.setAnchorX(self.rectCenter1, center1Anchor)
end

function FightTechniqueTipsView:tweenDoneCallback()
	self.tweenId = nil

	self:refreshPoint()
	self:refreshBtnState()
	self:refreshCenter(self.goCenter, self.simageicon, self.configList[self.curIndex])
	recthelper.setAnchorX(self.rectCenter, 0)
	gohelper.setActive(self.goCenter1, false)
end

function FightTechniqueTipsView:clearTween()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end
end

function FightTechniqueTipsView:onUpdateParam()
	self:initData()
	self:refreshCenter(self.goCenter, self.simageicon, self.configList[self.curIndex])
	self:refreshBtnState()
	self:refreshPoint()
end

function FightTechniqueTipsView:onOpen()
	self:initData()
	self:refreshCenter(self.goCenter, self.simageicon, self.configList[self.curIndex])
	self:refreshBtnState()
	self:refreshPoint()
	FightAudioMgr.instance:obscureBgm(true)
end

function FightTechniqueTipsView:initData()
	self.configList = {}

	if self.viewParam.isGMShow then
		self.config = self.viewParam.config
	else
		self.config = self.viewParam

		FightViewTechniqueModel.instance:readTechnique(self.config.id)
	end

	local curId = self.config.id
	local curGroup = self.config.group

	if not curGroup or curGroup == 0 then
		table.insert(self.configList, self.config)

		self.curIndex = 1
	else
		for _, co in ipairs(lua_fight_technique.configList) do
			if co.group == curGroup then
				table.insert(self.configList, co)

				if co.id == curId then
					self.curIndex = #self.configList
				end
			end
		end
	end

	self.configCount = #self.configList
end

function FightTechniqueTipsView:refreshCenter(goCenter, simage, config)
	simage:LoadImage(ResUrl.getTechniqueLangIcon(config.picture2 or "", config.isCn == 1))

	local string_list = FightStrUtil.instance:getSplitCache(config.content1, "|")
	local curId = tostring(config.id)
	local trContent = gohelper.findChildComponent(goCenter, "content", gohelper.Type_RectTransform)

	for i = 0, trContent.childCount - 1 do
		local child = trContent:GetChild(i)

		if child.name == curId then
			local go = child.gameObject

			gohelper.setActive(go, true)

			for j, str in ipairs(string_list) do
				str = string.gsub(str, "%{", string.format("<color=%s>", "#ff906a"))
				str = string.gsub(str, "%}", "</color>")

				local txt = gohelper.findChildTextMesh(go, "txt_" .. j)

				if txt then
					txt.text = str
				elseif isDebugBuild then
					logError(string.format("战斗指引id : %s, 未找到对应的文本节点 : %s", curId, j))
				end
			end
		else
			gohelper.setActive(child.gameObject, false)
		end
	end
end

function FightTechniqueTipsView:refreshBtnState()
	gohelper.setActive(self.goLeftBtn, self.curIndex > 1)
	gohelper.setActive(self.goRightBtn, self.curIndex < self.configCount)
end

function FightTechniqueTipsView:refreshPoint()
	for i = 1, self.configCount do
		local pointItem = self.pointItemList[i]

		pointItem = pointItem or self:createPointItem()

		recthelper.setAnchorX(pointItem.rectTr, 55 * (i - 0.5 * (self.configCount + 1)))
		gohelper.setActive(pointItem.go, true)
		gohelper.setActive(pointItem.goActive, i == self.curIndex)
		gohelper.setActive(pointItem.goNormal, i ~= self.curIndex)
	end

	for i = self.configCount + 1, #self.pointItemList do
		gohelper.setActive(self.pointItemList[i].go, false)
	end
end

function FightTechniqueTipsView:createPointItem()
	local path = self.viewContainer:getSetting().otherRes[1]
	local go = self:getResInst(path, self.goPointList, "pointItem")
	local pointItem = self:getUserDataTb_()

	pointItem.go = go
	pointItem.rectTr = go:GetComponent(gohelper.Type_RectTransform)
	pointItem.goActive = gohelper.findChild(go, "item1")
	pointItem.goNormal = gohelper.findChild(go, "item2")

	table.insert(self.pointItemList, pointItem)

	return pointItem
end

function FightTechniqueTipsView:onClose()
	FightAudioMgr.instance:obscureBgm(false)
end

function FightTechniqueTipsView:onDestroyView()
	self:clearTween()
	self.simageicon:UnLoadImage()

	if self.simageicon1 then
		self.simageicon1:UnLoadImage()
	end

	if self.leftClick then
		self.leftClick:RemoveClickListener()
	end

	if self.rightClick then
		self.rightClick:RemoveClickListener()
	end
end

return FightTechniqueTipsView
