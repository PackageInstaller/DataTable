-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/panelguide/view/PanelGuideView.lua

module("logic.extensions.panelguide.view.PanelGuideView", package.seeall)

local panelGuideBgs = {}
local moveRatio = 1
local centerThreshold = 50
local last3DragDelta = {
	0,
	0,
	0
}
local cellSizeX = 1280

panelGuideBgs[GameEnum.PanelGuideType.Pet] = {
	"bg_pet_guide_01",
	"bg_pet_guide_02",
	"bg_pet_guide_03",
	"bg_pet_guide_04"
}
panelGuideBgs[GameEnum.PanelGuideType.Formation] = {
	"bg_formation_guide_01",
	"mbzy_zhanqianbuzhen_kezhishuxing",
	"bg_formation_guide_02",
	"bg_formation_guide_03",
	"bg_formation_guide_04"
}
panelGuideBgs[GameEnum.PanelGuideType.Mofang] = {
	"bg_mofang_guide_01",
	"bg_mofang_guide_02",
	"bg_mofang_guide_03",
	"bg_mofang_guide_04"
}
panelGuideBgs[GameEnum.PanelGuideType.SourceMon] = {
	"mbzy_yuanshou_1",
	"mbzy_yuanshou_2",
	"mbzy_yuanshou_3",
	"mbzy_yuanshou_genghuan"
}
panelGuideBgs[GameEnum.PanelGuideType.PetEgg] = {
	"mbzy_fudan"
}
panelGuideBgs[GameEnum.PanelGuideType.PetsHandBook] = {
	"mbzy_tujian"
}
panelGuideBgs[GameEnum.PanelGuideType.DiamondTask] = {
	"mbzy_renwu"
}
panelGuideBgs[GameEnum.PanelGuideType.GodMonTrain] = {
	"mbzy_fuli_shenshoupeiyang"
}
panelGuideBgs[GameEnum.PanelGuideType.XiaoNuoBian] = {
	"bg_nuo_guide_01",
	"bg_nuo_guide_02"
}
panelGuideBgs[GameEnum.PanelGuideType.ActionMode] = {
	"mbzy_action_zhandouxinxi"
}

local PanelGuideView = class("PanelGuideView", ViewComponent)

function PanelGuideView:ctor()
	PanelGuideView.super.ctor(self)

	self.mainBgs = {}
	self.lines = {}
end

function PanelGuideView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnLeft:AddClickListener(self._onClickLeft, self)
	self._btnRight:AddClickListener(self._onClickRight, self)
end

function PanelGuideView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._btnLeft:RemoveClickListener()
	self._btnRight:RemoveClickListener()
end

function PanelGuideView:buildUI()
	self._canvasGroup = self.mainGO:GetComponent("CanvasGroup")
	self._closeButton = self:getBtn("main/btnClose")
	self._btnLeft = self:getBtn("main/btnLeft")
	self._btnRight = self:getBtn("main/btnRight")
	self._imgLeft = self._btnLeft.gameObject:GetComponent("Image")
	self._imgRight = self._btnRight.gameObject:GetComponent("Image")
	self._cloneBg = self:getGo("main/container/mainbg")

	table.insert(self.mainBgs, self._cloneBg)

	self._container = self:getGo("main/container")

	local blurBg = goutil.findChild(self.mainGO, "blurBg")

	blurBg:SetActive(false)

	local go = goutil.create("blurBg1")

	goutil.addChildToParent(go, self.mainGO)

	self._blurBg = goutil.addComponentOnce(go, typeof(StaticBluredScreen))
	self._drag = Framework.UIDragTrigger.Get(self:getGo("blurBg1"))
	self._springPosition = self._container:GetComponent(ComponentType.TweenSpringPosition)
	self._cloneLine = self:getGo("main/lines/line")

	table.insert(self.lines, self._cloneLine)

	self._txtDesc = goutil.findChildComponent(self.mainGO, "main/txtDesc", "Text")
	self._goMain = self:getGo("main")

	self._goMain.transform:SetAsLastSibling()
end

function PanelGuideView:destroyUI()
	return
end

function PanelGuideView:onEnter()
	self._canvasGroup.alpha = 0

	self._blurBg:Release()
	self._blurBg:Capture()
	self:_onCaptureScreenFinish()
end

function PanelGuideView:_onCaptureScreenFinish(tex)
	self._canvasGroup.alpha = 1

	local guideType = self._viewPresentor:getFirstParam()

	self._gameObjects = {}
	self._guideType = checknumber(guideType)

	if guideType > 0 then
		local t = panelGuideBgs[self._guideType]
		local len = #self.mainBgs

		self._len = #panelGuideBgs[self._guideType]

		for i = 1, #t do
			local go, line

			if i <= len then
				go = self.mainBgs[i]
				line = self.lines[i]
			else
				go = goutil.cloneAndSetParent(self._cloneBg, self._container.transform)
				line = goutil.cloneAndSetParent(self._cloneLine, self._cloneLine.transform.parent)

				table.insert(self.mainBgs, go)
				table.insert(self.lines, line)
			end

			goutil.setActive(go, true)
			goutil.setActive(line, true)

			local url = string.format("ui/bigbg/panelguide/%s.png", t[i])

			uGuiUtil.setSpriteToImage(go, uGuiUtil.SpriteType.BigBg, url)
			table.insert(self._gameObjects, go)
			Framework.TransformUtil.SetLocalPos(go.transform, (i - 1) * cellSizeX, 3, 0)
		end

		for i = #t + 1, len do
			goutil.setActive(self.mainBgs[i], false)
			goutil.setActive(self.lines[i], false)
		end
	end

	self._curIndex = 0

	Framework.TransformUtil.SetLocalPos(self._container.transform, 0, 0, 0)
	Framework.TransformUtil.SetLocalPos(self._txtDesc.transform, 96 + 28 * #panelGuideBgs[self._guideType], -340, 0)
	self:setArrowActive()
	self:updateLines()
	goutil.setActive(self._leftMask, false)
	goutil.setActive(self._rightMask, false)

	if self._len <= 1 then
		for i = 1, #self.lines do
			goutil.setActive(self.lines[i], false)
		end

		self._drag:RemoveBeginDragListener()
		self._drag:RemoveEndDragListener()
		self._drag:RemoveDragListener()
		goutil.setActive(self._txtDesc.gameObject, false)
	else
		self._drag:AddBeginDragListener(self._onBeginDrag, self)
		self._drag:AddEndDragListener(self._onEndDrag, self)
		self._drag:AddDragListener(self._onDrag, self)
		goutil.setActive(self._txtDesc.gameObject, true)
	end
end

function PanelGuideView:onEnterFinished()
	return
end

function PanelGuideView:onExit()
	local callbackOnClose = self._viewPresentor._openParam[2]

	if callbackOnClose then
		printInfo("执行回调")
		callbackOnClose()
	end

	for k, v in pairs(self._gameObjects) do
		local component = v:GetComponent(typeof(Framework.ImageBigBG))

		if component then
			component:ClearImage()
		end
	end

	self._drag:RemoveBeginDragListener()
	self._drag:RemoveEndDragListener()
	self._drag:RemoveDragListener()
end

function PanelGuideView:onExitFinished()
	return
end

function PanelGuideView:_onClickClose()
	self:close()
end

function PanelGuideView:_onClickLeft()
	self:_hideArrowBtn()

	self._curIndex = self._curIndex - 1

	self:_springToTargetPos()
end

function PanelGuideView:_onClickRight()
	self:_hideArrowBtn()

	self._curIndex = self._curIndex + 1

	self:_springToTargetPos()
end

function PanelGuideView:_springToTargetPos()
	self._curIndex = math.max(self._curIndex, 0)
	self._curIndex = math.min(self._curIndex, self._len - 1)

	local targetPos = Vector3.New(-cellSizeX * self._curIndex, 0, 0)

	SpringPosition.Begin(self._container, targetPos, 12)
	self:updateLines()
	settimer(0.3, function()
		self:setArrowActive()
		TweenUtil.ValueTo(0, 1, 0.2, function(val)
			Game.ImageUtil.SetImageAlpha(self._imgLeft, val)
			Game.ImageUtil.SetImageAlpha(self._imgRight, val)
		end, nil, self)
	end, nil, false)
end

function PanelGuideView:_hideArrowBtn()
	TweenUtil.ValueTo(0, 1, 0.2, function(val)
		Game.ImageUtil.SetImageAlpha(self._imgLeft, 1 - val)
		Game.ImageUtil.SetImageAlpha(self._imgRight, 1 - val)
	end, nil, self)
end

function PanelGuideView:_onBeginDrag()
	self._springPosition.enabled = false

	local x, y, z = Framework.TransformUtil.GetLocalPos(self._container.transform, 0, 0, 0)

	self._curLocalPosX = x
	self._curDelta = 0

	self:_hideArrowBtn()

	last3DragDelta = {
		0,
		0,
		0
	}
end

function PanelGuideView:_onDrag(eventData)
	last3DragDelta[3] = last3DragDelta[2]
	last3DragDelta[2] = last3DragDelta[1]
	last3DragDelta[1] = eventData.delta.x
	self._curDelta = self._curDelta + eventData.delta.x * moveRatio

	local targetPos = self._curLocalPosX + self._curDelta

	targetPos = math.min(targetPos, 300)
	targetPos = math.max(targetPos, -(self._len - 1) * cellSizeX - 300)

	Framework.TransformUtil.SetLocalPos(self._container.transform, targetPos, 0, 0)
end

function PanelGuideView:_onEndDrag(eventData)
	local avg = 0

	for _, v in ipairs(last3DragDelta) do
		avg = avg + v
	end

	local x, y, z = Framework.TransformUtil.GetLocalPos(self._container.transform, 0, 0, 0)
	local temp = math.floor(-x / cellSizeX + 0.5)

	temp = math.max(temp, 0)
	temp = math.min(temp, self._len - 1)
	self._curIndex = temp

	if math.abs(avg) >= centerThreshold then
		local sign = avg > 0 and -1 or 1

		self._curIndex = self._curIndex + sign
	end

	self:_springToTargetPos()
end

function PanelGuideView:setArrowActive()
	local len = #panelGuideBgs[self._guideType]

	goutil.setActive(self._btnLeft.gameObject, self._curIndex > 0)
	goutil.setActive(self._btnRight.gameObject, self._curIndex < len - 1)
end

function PanelGuideView:updateLines()
	local len = #panelGuideBgs[self._guideType]

	for i = 1, len do
		local imgSpriteChange = self.lines[i]:GetComponent("UIImageSpriteChange")

		imgSpriteChange:ChangeStateNow(i == self._curIndex + 1 and 1 or 0)
	end
end

return PanelGuideView
