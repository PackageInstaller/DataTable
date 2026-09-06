-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/shikongshenglong/ZxlpresentwishView.lua

module("logic.extensions.timelimitedchallenge.view.shikongshenglong.ZxlpresentwishView", package.seeall)

local ZxlpresentwishView = class("ZxlpresentwishView", ViewComponent)

function ZxlpresentwishView:ctor()
	ZxlpresentwishView.super.ctor(self)
end

function ZxlpresentwishView:unbindEvents()
	ZxlpresentwishView.super.unbindEvents(self)
end

function ZxlpresentwishView:bindEvents()
	ZxlpresentwishView.super.bindEvents(self)
end

function ZxlpresentwishView:buildUI()
	ZxlpresentwishView.super.buildUI(self)

	local listTran = self:getGo("maskView/view/list").transform
	local count = listTran.childCount

	self.textList = {}

	for i = 1, count do
		local text = listTran:GetChild(i - 1):GetComponent(goutil.Type_UIText)

		table.insert(self.textList, text)
	end
end

function ZxlpresentwishView:onExit()
	ZxlpresentwishView.super.onExit(self)
end

function ZxlpresentwishView:onEnter()
	ZxlpresentwishView.super.onEnter(self)

	local cfgs = ShikongshenglongConfig.instance:getBuffCfgs(ShikongshenglongModel.instance.curStageId)
	local index = 1

	for k, v in pairs(cfgs) do
		self.textList[index].text = v.desc

		self.textList[index].gameObject:SetActive(true)

		index = index + 1
	end

	for i = index, #self.textList do
		self.textList[i].gameObject:SetActive(false)
	end
end

return ZxlpresentwishView
