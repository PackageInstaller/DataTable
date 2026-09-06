-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexiuerclg/view/DivineXiuErClgExtParallelSureView.lua

module("logic.extensions.divinexiuerclg.view.DivineXiuErClgExtParallelSureView", package.seeall)

local DivineXiuErClgExtParallelSureView = class("DivineXiuErClgExtParallelSureView", ViewComponent)

function DivineXiuErClgExtParallelSureView:buildUI()
	DivineXiuErClgExtParallelSureView.super.buildUI(self)

	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")
	self._descCol = goutil.findChild(self.mainGO, "descCol")
	self._descView = goutil.findChild(self.mainGO, "descCol/descView")
	self._descCell = goutil.findChild(self.mainGO, "descCol/descCell")
	self._btnSure = goutil.findChild(self.mainGO, "btnSure")

	GameUtil.SetActive(self._descCell, false)
end

function DivineXiuErClgExtParallelSureView:bindEvents()
	DivineXiuErClgExtParallelSureView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function DivineXiuErClgExtParallelSureView:unbindEvents()
	DivineXiuErClgExtParallelSureView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function DivineXiuErClgExtParallelSureView:onEnter()
	DivineXiuErClgExtParallelSureView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	if not params[1] then
		local info = {}

		self._isWin = checkbool(info.isWin)
		self._descInfoList = info.descInfoList or {}
		self._sureCallBack = info.sureCallBack
		self._txtTitle.text = self._isWin and "战斗胜利" or "战斗失败"

		local parentTran = self._descView.transform
		local childGo = self._descCell
		local children = GameUtil.getChildren(parentTran)
		local length = #self._descInfoList

		for idx, descInfo in ipairs(self._descInfoList) do
			local mainGo = children[idx]

			if mainGo == nil then
				mainGo = goutil.cloneAndSetParent(childGo, parentTran, string.format("%s_%s", childGo.name, idx))
			end

			local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")
			local imgYes = goutil.findChild(mainGo, "imgYes")
			local imgNo = goutil.findChild(mainGo, "imgNo")

			txtDesc.text = descInfo.desc

			GameUtil.SetActive(imgYes, descInfo.isReach)
			GameUtil.SetActive(imgNo, not GameUtil.GetActive(imgYes))
		end

		for idx = 1, parentTran.childCount do
			local mainGo = parentTran:GetChild(idx - 1)

			GameUtil.SetActive(mainGo, idx <= length)
		end

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(parentTran:GetComponent(goutil.Type_RectTransform))
	end
end

function DivineXiuErClgExtParallelSureView:onExit()
	DivineXiuErClgExtParallelSureView.super.onExit(self)

	local parentTran = self._descView.transform
	local children = GameUtil.getChildren(parentTran)

	for i, mainGo in ipairs(children) do
		-- block empty
	end
end

function DivineXiuErClgExtParallelSureView:_onClickBtnSure()
	GameUtil.callBack(self._sureCallBack)
	self:close()
end

function DivineXiuErClgExtParallelSureView:_onClickBtnCancel()
	GameUtil.callBack(self._cancelCallBack)
	self:close()
end

return DivineXiuErClgExtParallelSureView
