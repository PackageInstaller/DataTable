-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mount/view/MountmarkupView.lua

module("logic.extensions.mount.view.MountmarkupView", package.seeall)

local MountmarkupView = class("MountmarkupView", TableViewComponent)

function MountmarkupView:_getPath()
	return {
		cellPath = "cell",
		viewPath = "scrollView"
	}
end

function MountmarkupView:ctor()
	MountmarkupView.super.ctor(self)
end

function MountmarkupView:buildUI()
	MountmarkupView.super.buildUI(self)

	self.bgBtn = GameUtil.asBtn(self:getGo("bg"))
end

function MountmarkupView:bindEvents()
	MountmarkupView.super.bindEvents(self)
	self.bgBtn:AddClickListener(self.close, self)
end

function MountmarkupView:unbindEvents()
	MountmarkupView.super.unbindEvents(self)
	self.bgBtn:RemoveClickListener()
end

function MountmarkupView:destroyUI()
	MountmarkupView.super.destroyUI(self)
end

function MountmarkupView:onEnter()
	MountmarkupView.super.onEnter(self)

	self.mountId = self._viewPresentor._openParam[1]
	self._curViewDatas = MountModel.instance:getActivationAtt(self.mountId)

	self:reloadData()
end

function MountmarkupView:onEnterFinished()
	MountmarkupView.super.onEnterFinished(self)
end

function MountmarkupView:onExit()
	MountmarkupView.super.onExit(self)
end

function MountmarkupView:onExitFinished()
	MountmarkupView.super.onExitFinished(self)
end

function MountmarkupView:_updateCell(view, cell, data)
	local _txtAtt = goutil.findChildComponent(cell, "txtAtt", "Text")
	local _txtTitle = goutil.findChildComponent(cell, "txtTitle", "Text")
	local mo = MountModel.instance:getLockmountsById(self.mountId)

	if mo then
		if not mo.level then
			local level = 0
			local color = level < data.level and "666C7CFF" or "008d1aff"

			_txtTitle.text = data.level .. "阶段突破加成"

			local arr = string.split(data.attribute, "+")
			local id = table.indexof(GameEnum.AttrTypeName, arr[1])
			local value = checknumber(arr[2])
			local propertyVal = GameUtil.GetPropertyValue(id, value)

			_txtAtt.text = string.format("<color=#%s>全体上阵精灵%s+%s</color>", color, arr[1], propertyVal)
		end
	end
end

return MountmarkupView
