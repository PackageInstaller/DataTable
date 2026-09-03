-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/home/view/DebugBustShowViewMediator2.lua

DebugBustShowViewMediator2 = class("DebugBustShowViewMediator2", DmAreaViewMediator)

DebugBustShowViewMediator2:has("_developSystem", {
	is = "r"
}):injectWith(DevelopSystem)

local kBtnHandlers = {
	["main.Button_19"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickRight"
	},
	["main.Button_20"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickLeft"
	},
	["main.Button_17"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickBack"
	},
	["main.Button_21"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickChange"
	},
	["main.Button_20_0"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickPageLeft"
	},
	["main.Button_19_0"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickPageRight"
	}
}

function DebugBustShowViewMediator2:initialize()
	super.initialize(self)
end

function DebugBustShowViewMediator2:dispose()
	super.dispose(self)
end

function DebugBustShowViewMediator2:onRegister()
	super.onRegister(self)

	self._heroSystem = self._developSystem:getHeroSystem()

	self:mapButtonHandlersClick(kBtnHandlers)
	self:initData()
end

function DebugBustShowViewMediator2:onClickBack()
	self:dismiss()
end

function DebugBustShowViewMediator2:enterWithData(data)
	self._modelId = data.id
	self._frameId = self._bustFrames[1]
	self._flag = data.flag

	if data.flag == 1 then
		self._index = table.find(self._masterData, self._modelId)
	end

	if data.flag == 2 then
		self._index = table.find(self._heroData, self._modelId)
	end

	if data.flag == 3 then
		self._index = table.find(self._allData, self._modelId)
	end

	self._pageIndex = 1

	self:initView()
end

local unuse_fid = {
	"bustframe6_4",
	"bustframe4_10",
	"bustframe5_1",
	"bustframe5",
	"bustframe7_3",
	"bustframe19",
	"bustframe20"
}
local diff_fid = {
	"bustframe4_7",
	"bustframe6_6",
	"bustframe18"
}

function DebugBustShowViewMediator2:initData()
	self._masterData = {}
	self._heroData = {}
	self._awakeData = {}
	self._surface = {}
	self._allData = {}

	local dataTable = ConfigReader:getDataTable("RoleModel")

	for k, v in pairs(dataTable) do
		local picType = v.PicType
		local path = v.Path

		if path and path ~= "" then
			if picType == 1 then
				table.insert(self._masterData, v.Id)
				table.insert(self._allData, v.Id)
			elseif picType == 2 then
				table.insert(self._heroData, v.Id)
				table.insert(self._allData, v.Id)
			elseif picType == 3 then
				table.insert(self._surface, v.Id)
				table.insert(self._allData, v.Id)
			elseif picType == 5 then
				table.insert(self._heroData, v.Id)
				table.insert(self._awakeData, v.Id)
				table.insert(self._allData, v.Id)
			end
		end
	end

	self._bustFrames = {}

	local dataTable = ConfigReader:getDataTable("BustFrame")

	for k, v in pairs(dataTable) do
		local fid = v.Id

		if not table.find(unuse_fid, fid) and not table.find(diff_fid, fid) then
			table.insert(self._bustFrames, v.Id)
		end
	end

	self._zhujueFrames = {
		"bustframe13_3",
		"bustframe13_4",
		"bustframe13_7",
		"bustframe13_8",
		"bustframe13_9",
		"bustframe13_10",
		"bustframe1",
		"bustframe2_2",
		"bustframe4_1",
		"bustframe4_2",
		"bustframe4_3",
		"bustframe4_4",
		"bustframe4_5",
		"bustframe4_9",
		"bustframe6_1",
		"bustframe6_2",
		"bustframe6_3"
	}
	self._huobanframes = {
		"bustframe3",
		"bustframe4_8",
		"bustframe7_1",
		"bustframe7_2",
		"bustframe8",
		"bustframe13_1",
		"bustframe13_2",
		"bustframe21"
	}
	self._huobanAndZhujueFrames = {
		"bustframe10",
		"bustframe11"
	}
end

function DebugBustShowViewMediator2:initView()
	self._main = self:getView():getChildByFullName("main")
	self._editBox = self._main:getChildByFullName("TextField")

	if self._editBox:getDescription() == "TextField" then
		self._editBox:setString("")
	end

	self._editBox:setString(self._modelId)

	self._editBox = convertTextFieldToEditBox(self._editBox, nil, MaskWordType.CHAT)

	self._editBox:onEvent(function(eventName, sender)
		return
	end)
	self:refreshView2()
end

function DebugBustShowViewMediator2:refreshView2()
	if self._flag == 1 then
		if self._pageIndex == 1 then
			local index = 1

			for i = 1, 8, 2 do
				local node = self._main:getChildByFullName("Node_" .. index)

				node:removeAllChildren()

				if i <= 5 then
					local info = {
						id = self._modelId,
						frameId = self._zhujueFrames[i + 1]
					}
					local heroIcon = IconFactory:createRoleIconSpriteNew(info)

					heroIcon:addTo(node):center(node:getContentSize())
					heroIcon:setOpacity(127.5)
					heroIcon:setLocalZOrder(2)

					local info = {
						id = self._modelId,
						frameId = self._zhujueFrames[i]
					}
					local heroIcon = IconFactory:createRoleIconSpriteNew(info)

					heroIcon:addTo(node):center(node:getContentSize())
					heroIcon:setLocalZOrder(2)

					local layout = ccui.Layout:create()

					layout:setContentSize(cc.size(heroIcon:getContentSize().width, heroIcon:getContentSize().height))
					node:addChild(layout)
					layout:setAnchorPoint(cc.p(0.5, 0.5))
					layout:setPosition(heroIcon:getPosition())
					layout:setBackGroundColorType(1)
					layout:setBackGroundColor(cc.c3b(200, 200, 0))
					layout:setBackGroundColorOpacity(127.5)
					layout:setLocalZOrder(0)
					node:setScale(0.7)

					local editBox = self._main:getChildByFullName("TextField_" .. index)

					editBox:setString(info.frameId)

					index = index + 1
				end
			end

			index = 4

			for i = 7, 11 do
				local node = self._main:getChildByFullName("Node_" .. index)

				node:removeAllChildren()

				local info = {
					id = self._modelId,
					frameId = self._zhujueFrames[i]
				}
				local heroIcon = IconFactory:createRoleIconSpriteNew(info)

				heroIcon:addTo(node):center(node:getContentSize())
				heroIcon:setLocalZOrder(2)

				local layout = ccui.Layout:create()

				layout:setContentSize(cc.size(heroIcon:getContentSize().width, heroIcon:getContentSize().height))
				node:addChild(layout)
				layout:setAnchorPoint(cc.p(0.5, 0.5))
				layout:setPosition(heroIcon:getPosition())
				layout:setBackGroundColorType(1)
				layout:setBackGroundColor(cc.c3b(200, 200, 0))
				layout:setBackGroundColorOpacity(127.5)
				layout:setLocalZOrder(0)
				node:setScale(0.7)

				local editBox = self._main:getChildByFullName("TextField_" .. index)

				editBox:setString(info.frameId)

				index = index + 1
			end
		end

		if self._pageIndex == 2 then
			local index = 1

			for i = 12, 17 do
				local node = self._main:getChildByFullName("Node_" .. index)

				node:removeAllChildren()

				local info = {
					id = self._modelId,
					frameId = self._zhujueFrames[i]
				}
				local heroIcon = IconFactory:createRoleIconSpriteNew(info)

				heroIcon:addTo(node):center(node:getContentSize())
				heroIcon:setLocalZOrder(2)

				local layout = ccui.Layout:create()

				layout:setContentSize(cc.size(heroIcon:getContentSize().width, heroIcon:getContentSize().height))
				node:addChild(layout)
				layout:setAnchorPoint(cc.p(0.5, 0.5))
				layout:setPosition(heroIcon:getPosition())
				layout:setBackGroundColorType(1)
				layout:setBackGroundColor(cc.c3b(200, 200, 0))
				layout:setBackGroundColorOpacity(127.5)
				layout:setLocalZOrder(0)
				node:setScale(0.7)

				local editBox = self._main:getChildByFullName("TextField_" .. index)

				editBox:setString(info.frameId)

				index = index + 1
			end
		end

		self._editBox:setText(self._modelId)

		local text_fid = self._main:getChildByFullName("text_page")

		text_fid:setString(self._index .. "/" .. #self._masterData)
	end

	if self._flag == 2 then
		for i = 1, 8 do
			local index = i
			local node = self._main:getChildByFullName("Node_" .. index)

			node:removeAllChildren()

			local info = {
				id = self._modelId,
				frameId = self._huobanframes[i]
			}
			local heroIcon = IconFactory:createRoleIconSpriteNew(info)

			heroIcon:addTo(node):center(node:getContentSize())
			heroIcon:setLocalZOrder(2)

			local layout = ccui.Layout:create()

			layout:setContentSize(cc.size(heroIcon:getContentSize().width, heroIcon:getContentSize().height))
			node:addChild(layout)
			layout:setAnchorPoint(cc.p(0.5, 0.5))
			layout:setPosition(heroIcon:getPosition())
			layout:setBackGroundColorType(1)
			layout:setBackGroundColor(cc.c3b(200, 200, 0))
			layout:setBackGroundColorOpacity(127.5)
			layout:setLocalZOrder(0)
			node:setScale(0.6)

			if index == 8 then
				node:setScale(0.28)
			end

			local editBox = self._main:getChildByFullName("TextField_" .. index)

			editBox:setString(info.frameId)
			self._editBox:setText(self._modelId)

			local text_fid = self._main:getChildByFullName("text_page")

			text_fid:setString(self._index .. "/" .. #self._heroData)
		end
	end

	if self._flag == 3 then
		for i = 1, 8 do
			local index = i
			local node = self._main:getChildByFullName("Node_" .. index)

			node:removeAllChildren()

			if i > 2 then
				break
			end

			local info = {
				id = self._modelId,
				frameId = self._huobanAndZhujueFrames[i]
			}
			local heroIcon = IconFactory:createRoleIconSpriteNew(info)

			heroIcon:addTo(node):center(node:getContentSize())
			heroIcon:setLocalZOrder(2)

			local layout = ccui.Layout:create()

			layout:setContentSize(cc.size(heroIcon:getContentSize().width, heroIcon:getContentSize().height))
			node:addChild(layout)
			layout:setAnchorPoint(cc.p(0.5, 0.5))
			layout:setPosition(heroIcon:getPosition())
			layout:setBackGroundColorType(1)
			layout:setBackGroundColor(cc.c3b(200, 200, 0))
			layout:setBackGroundColorOpacity(127.5)
			layout:setLocalZOrder(0)

			local editBox = self._main:getChildByFullName("TextField_" .. index)

			editBox:setString(info.frameId)
			self._editBox:setText(self._modelId)

			local text_fid = self._main:getChildByFullName("text_page")

			text_fid:setString(self._index .. "/" .. #self._allData)
		end
	end
end

function DebugBustShowViewMediator2:onClickLeft()
	if self._flag == 1 then
		self._index = self._index - 1
		self._index = math.max(self._index, 1)
		self._modelId = self._masterData[self._index]
	end

	if self._flag == 2 then
		self._index = self._index - 1
		self._index = math.max(self._index, 1)
		self._modelId = self._heroData[self._index]
	end

	if self._flag == 3 then
		self._index = self._index - 1
		self._index = math.max(self._index, 1)
		self._modelId = self._allData[self._index]
	end

	self:refreshView2()
end

function DebugBustShowViewMediator2:onClickRight()
	if self._flag == 1 then
		self._index = self._index + 1
		self._index = math.min(self._index, #self._masterData)
		self._modelId = self._masterData[self._index]
	end

	if self._flag == 2 then
		self._index = self._index + 1
		self._index = math.min(self._index, #self._heroData)
		self._modelId = self._heroData[self._index]
	end

	if self._flag == 3 then
		self._index = self._index + 1
		self._index = math.min(self._index, #self._allData)
		self._modelId = self._allData[self._index]
	end

	self:refreshView2()
end

function DebugBustShowViewMediator2:onClickPageLeft()
	if self._flag == 1 then
		self._pageIndex = self._pageIndex - 1
		self._pageIndex = math.max(self._pageIndex, 1)
	end

	if self._flag == 2 then
		self._pageIndex = self._pageIndex - 1
		self._pageIndex = math.max(self._pageIndex, 1)
	end

	self:refreshView2()
end

function DebugBustShowViewMediator2:onClickPageRight()
	if self._flag == 1 then
		self._pageIndex = self._pageIndex + 1
		self._pageIndex = math.min(self._pageIndex, 2)
	end

	if self._flag == 2 then
		self._pageIndex = self._pageIndex + 1
		self._pageIndex = math.min(self._pageIndex, 1)
	end

	self:refreshView2()
end

function DebugBustShowViewMediator2:onClickChange()
	return
end
