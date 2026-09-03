-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/home/view/DebugBustShowViewMediator.lua

DebugBustShowViewMediator = class("DebugBustShowViewMediator", DmAreaViewMediator)

DebugBustShowViewMediator:has("_developSystem", {
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
	}
}

function DebugBustShowViewMediator:initialize()
	super.initialize(self)
end

function DebugBustShowViewMediator:dispose()
	super.dispose(self)
end

function DebugBustShowViewMediator:onRegister()
	super.onRegister(self)

	self._heroSystem = self._developSystem:getHeroSystem()

	self:mapButtonHandlersClick(kBtnHandlers)
	self:initData()
end

function DebugBustShowViewMediator:onClickBack()
	self:dismiss()
end

function DebugBustShowViewMediator:enterWithData(data)
	self._modelId = data.id
	self._frameId = self._bustFrames[1]
	self._index = table.find(self._heroData, self._modelId)

	self:initView()

	for i = 1, 3 do
		local fid = self._main:getChildByFullName("text_f" .. i)

		fid:setString(self._bustFrames[i])
	end
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

function DebugBustShowViewMediator:initData()
	self._masterData = {}
	self._heroData = {}
	self._awakeData = {}
	self._surface = {}

	local dataTable = ConfigReader:getDataTable("RoleModel")

	for k, v in pairs(dataTable) do
		local picType = v.PicType
		local path = v.Path

		if path and path ~= "" then
			if picType == 1 then
				table.insert(self._masterData, v.Id)
			elseif picType == 2 then
				table.insert(self._heroData, v.Id)
			elseif picType == 3 then
				table.insert(self._surface, v.Id)
			elseif picType == 5 then
				table.insert(self._heroData, v.Id)
				table.insert(self._awakeData, v.Id)
			end
		end
	end

	self._bustFrames = {}

	local dataTable = ConfigReader:getDataTable("BustFrame")

	for k, v in pairs(dataTable) do
		local fid = v.Id

		if not table.find(unuse_fid, fid) then
			table.insert(self._bustFrames, v)
		end
	end

	self._bustFrames = {
		"bustframe4_7",
		"bustframe6_6",
		"bustframe18"
	}
end

function DebugBustShowViewMediator:initView()
	self._main = self:getView():getChildByFullName("main")

	local textMid = self._main:getChildByFullName("text_id")

	self._editBox = self._main:getChildByFullName("TextField")

	if self._editBox:getDescription() == "TextField" then
		self._editBox:setString("")
	end

	self._editBox:setString(self._modelId)

	self._editBox = convertTextFieldToEditBox(self._editBox, nil, MaskWordType.CHAT)

	self._editBox:onEvent(function(eventName, sender)
		print("========== eventName  " .. eventName)
	end)
	self:refreshView()
end

function DebugBustShowViewMediator:refreshView()
	local panel = self._main:getChildByFullName("node_1.panel")

	panel:removeAllChildren()

	local info = {
		frameId = "bustframe4_7",
		id = self._modelId
	}

	if not table.find(self._surface, info.id) and not table.find(self._awakeData, info.id) then
		local heroIcon = IconFactory:createRoleIconSpriteNew(info)

		heroIcon:setScale(0.8)
		heroIcon:addTo(panel):center(panel:getContentSize())
	end

	local roleNode = self._main:getChildByFullName("bossCell.roleNode")

	roleNode:removeAllChildren()

	local info = {
		useAnim = true,
		frameId = "bustframe6_6",
		id = self._modelId
	}

	if not table.find(self._surface, info.id) and not table.find(self._awakeData, info.id) then
		local masterIcon = IconFactory:createRoleIconSpriteNew(info)

		masterIcon:setAnchorPoint(cc.p(0.5, 0.5))
		masterIcon:addTo(roleNode):center(roleNode:getContentSize())
		masterIcon:setRotation(-45)
	end

	local info = {
		frameId = "bustframe18",
		id = self._modelId
	}
	local awakeRoleNode = self._main:getChildByFullName("herobase.heropanel")

	awakeRoleNode:removeAllChildren()

	if table.find(self._awakeData, info.id) then
		local masterIcon = IconFactory:createRoleIconSpriteNew(info)

		masterIcon:addTo(awakeRoleNode)
		masterIcon:setPosition(cc.p(0, 200))
		masterIcon:setRotation(15.5)
	end

	local textMid = self._main:getChildByFullName("text_id")
	local textfid = self._main:getChildByFullName("")

	textMid:setString("")
	self._editBox:setText(self._modelId)

	local textPage = self._main:getChildByFullName("text_page")

	textPage:setString(self._index .. "/" .. #self._heroData)
end

function DebugBustShowViewMediator:onClickLeft()
	self._index = self._index - 1
	self._index = math.max(self._index, 1)
	self._modelId = self._heroData[self._index]

	self:refreshView()
end

function DebugBustShowViewMediator:onClickRight()
	self._index = self._index + 1
	self._index = math.min(self._index, #self._heroData)
	self._modelId = self._heroData[self._index]

	self:refreshView()
end

function DebugBustShowViewMediator:onClickChange()
	return
end
