-- chunkname: @modules/logic/balanceumbrella/view/BalanceUmbrellaView.lua

module("modules.logic.balanceumbrella.view.BalanceUmbrellaView", package.seeall)

local BalanceUmbrellaView = class("BalanceUmbrellaView", BaseView)

function BalanceUmbrellaView:onInitView()
	self._gonofull = gohelper.findChild(self.viewGO, "#simage_title_normal")
	self._gofull = gohelper.findChild(self.viewGO, "#simage_title_finished")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function BalanceUmbrellaView:_editableInitView()
	self._clues = self:getUserDataTb_()
	self._lines = self:getUserDataTb_()
	self._points = self:getUserDataTb_()

	local clueRoot = gohelper.findChild(self.viewGO, "Clue").transform

	for i = 0, clueRoot.childCount - 1 do
		local child = clueRoot:GetChild(i)
		local index = string.match(child.name, "clue([0-9]+)")

		if index then
			index = tonumber(index)
			self._clues[index] = child:GetComponent(typeof(UnityEngine.Animator))

			local btn = gohelper.findChildButtonWithAudio(child.gameObject, "")

			self.addClickCb(self, btn, self._showDetail, self, index)
		end
	end

	local lineRoot = gohelper.findChild(self.viewGO, "Line").transform

	for i = 0, lineRoot.childCount - 1 do
		local child = lineRoot:GetChild(i)
		local lineStartIndex, lineEndIndex = string.match(child.name, "line([0-9]+)_([0-9]+)")

		if lineStartIndex then
			lineStartIndex = tonumber(lineStartIndex)
			lineEndIndex = tonumber(lineEndIndex)
			self._lines[child.name] = {
				anim = child:GetComponent(typeof(UnityEngine.Animator)),
				startIndex = lineStartIndex,
				endIndex = lineEndIndex
			}
		end

		local pointIndex = string.match(child.name, "point([0-9]+)")

		if pointIndex then
			pointIndex = tonumber(pointIndex)
			self._points[pointIndex] = child
		end
	end
end

function BalanceUmbrellaView:_showDetail(index)
	ViewMgr.instance:openView(ViewName.BalanceUmbrellaClueView, {
		id = index
	})
end

function BalanceUmbrellaView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_unlock)

	local isFull = BalanceUmbrellaModel.instance:isGetAllClue()

	gohelper.setActive(self._gofull, isFull)
	gohelper.setActive(self._gonofull, not isFull)

	self._newIds = BalanceUmbrellaModel.instance:getAllNoPlayIds()

	UIBlockHelper.instance:startBlock("BalanceUmbrellaView_playclue", 999, self.viewName)
	UIBlockMgrExtend.setNeedCircleMv(false)

	for id, image in pairs(self._clues) do
		if BalanceUmbrellaModel.instance:isClueUnlock(id) and not tabletool.indexOf(self._newIds, id) then
			gohelper.setActive(image, true)
		else
			gohelper.setActive(image, false)
		end
	end

	for id, point in pairs(self._points) do
		if BalanceUmbrellaModel.instance:isClueUnlock(id) and not tabletool.indexOf(self._newIds, id) then
			gohelper.setActive(point, true)
		else
			gohelper.setActive(point, false)
		end
	end

	for _, lineInfo in pairs(self._lines) do
		local startIndex = lineInfo.startIndex
		local endIndex = lineInfo.endIndex

		if BalanceUmbrellaModel.instance:isClueUnlock(startIndex) and not tabletool.indexOf(self._newIds, startIndex) and BalanceUmbrellaModel.instance:isClueUnlock(endIndex) and not tabletool.indexOf(self._newIds, endIndex) then
			gohelper.setActive(lineInfo.anim, true)
		else
			gohelper.setActive(lineInfo.anim, false)
		end
	end

	self:beginPlayNew()
	BalanceUmbrellaModel.instance:markAllNoPlayIds()
end

function BalanceUmbrellaView:beginPlayNew()
	local newId = table.remove(self._newIds, 1)

	if newId then
		self._playingId = newId

		self:playLineAnim(newId)
	else
		self:endPlayNew()
	end
end

function BalanceUmbrellaView:playLineAnim(id)
	local allNewLine = {}

	for _, lineInfo in pairs(self._lines) do
		if lineInfo.endIndex == id then
			gohelper.setActive(lineInfo.anim, true)
			table.insert(allNewLine, lineInfo)
		end
	end

	if #allNewLine > 0 then
		self._newLines = allNewLine

		for _, lineInfo in pairs(self._newLines) do
			lineInfo.anim:Play("open", 0, 0)
		end

		TaskDispatcher.runDelay(self._onFinishLineAnim, self, 0.667)
	else
		self:playImgAnim(id)
	end
end

function BalanceUmbrellaView:_onFinishLineAnim()
	self:playImgAnim(self._playingId)
end

function BalanceUmbrellaView:playImgAnim(id)
	gohelper.setActive(self._clues[id], true)
	self._clues[id]:Play("open", 0, 0)
	TaskDispatcher.runDelay(self._imageAnimEnd, self, 0.667)
end

function BalanceUmbrellaView:_imageAnimEnd()
	gohelper.setActive(self._points[self._playingId], true)
	self:beginPlayNew()
end

function BalanceUmbrellaView:endPlayNew()
	self._playingId = nil

	TaskDispatcher.cancelTask(self._onFinishLineAnim, self)
	TaskDispatcher.cancelTask(self._imageAnimEnd, self)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockHelper.instance:endBlock("BalanceUmbrellaView_playclue")
end

function BalanceUmbrellaView:onClose()
	self:endPlayNew()
end

return BalanceUmbrellaView
