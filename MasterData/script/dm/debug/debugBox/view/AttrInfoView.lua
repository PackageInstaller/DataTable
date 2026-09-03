-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/AttrInfoView.lua

AttrInfoView = class("AttrInfoView", DebugViewTemplate, _M)

function AttrInfoView:initialize()
	self._opType = 141
	self._viewConfig = {
		{
			default = "2",
			name = "showType",
			title = "前端展示1主角2伙伴",
			type = "Input"
		},
		{
			default = "Master_XueZhan",
			name = "masterId",
			_selectBoxShow = true,
			type = "SelectBox",
			title = "主角Id",
			selectHandler = function(selectStr)
				local ret = {}
				local maxRows = 50

				if string.len(selectStr) > 0 and not GameConfigs.useLuaCfg then
					local dataTable = DataReader:getDBTable("MasterBase")
					local datas = dataTable.table:getRowsByConditionStr("inner join Translate on MasterBase.Name_key = Translate.Id where MasterBase.Id like \"%" .. selectStr .. "%\" or Translate.Zh_CN_key like \"%" .. selectStr .. "%\";")
					local translateDataTable = DataReader:getDBTable("Translate")
					local keys = {}

					for k, v in pairs(dataTable.columnNames) do
						table.insert(keys, v)
					end

					for k, v in pairs(translateDataTable.columnNames) do
						table.insert(keys, v)
					end

					local idIdx, nameIdx

					for k, v in pairs(keys) do
						if v == "Id" and idIdx == nil then
							idIdx = k
						elseif v == "Zh_CN" and nameIdx == nil then
							nameIdx = k
						end
					end

					local idx = 1

					for k, v in pairs(datas) do
						table.insert(ret, {
							v[idIdx],
							v[nameIdx]
						})

						if maxRows <= idx then
							break
						end

						idx = idx + 1
					end
				end

				return ret
			end
		},
		{
			default = "ZTXChang",
			name = "heroId",
			_selectBoxShow = true,
			type = "SelectBox",
			title = "伙伴Id",
			selectHandler = function(selectStr)
				local ret = {}
				local maxRows = 50

				if string.len(selectStr) > 0 and not GameConfigs.useLuaCfg then
					local dataTable = DataReader:getDBTable("HeroBase")
					local datas = dataTable.table:getRowsByConditionStr("inner join Translate on HeroBase.Name_key = Translate.Id where HeroBase.Id like \"%" .. selectStr .. "%\" or Translate.Zh_CN_key like \"%" .. selectStr .. "%\";")
					local translateDataTable = DataReader:getDBTable("Translate")
					local keys = {}

					for k, v in pairs(dataTable.columnNames) do
						table.insert(keys, v)
					end

					for k, v in pairs(translateDataTable.columnNames) do
						table.insert(keys, v)
					end

					local idIdx, nameIdx

					for k, v in pairs(keys) do
						if v == "Id" and idIdx == nil then
							idIdx = k
						elseif v == "Zh_CN" and nameIdx == nil then
							nameIdx = k
						end
					end

					local idx = 1

					for k, v in pairs(datas) do
						table.insert(ret, {
							v[idIdx],
							v[nameIdx]
						})

						if maxRows <= idx then
							break
						end

						idx = idx + 1
					end
				end

				return ret
			end
		}
	}
end

function AttrInfoView:onClick(data)
	self:initData(data)
	self:createPanelLayer()
	self:createAttr()

	if tonumber(data.showType) == 1 then
		data.heroId = ""
	else
		data.masterId = ""
	end

	local dataModificationDS = self:getInjector():getInstance(DataModificationDS)

	dataModificationDS:requestTest(data, function(response)
		local isSucc = response.resCode == GS_SUCCESS

		self:dispatch(ShowTipEvent({
			tip = Strings:get(isSucc and "EXEC_SUCC" or "EXEC_FAIL")
		}))
	end)
end

function AttrInfoView:initData(data)
	local showType = data.showType

	self._evnType = "SCENE_ALL"

	local developSystem = self:getInjector():getInstance(DevelopSystem)

	self._player = developSystem:getPlayer()
	self._heroSystem = developSystem:getHeroSystem()
	self._masterSystem = developSystem:getMasterSystem()
	self._parent = cc.Director:getInstance():getRunningScene()
	self._singleRole = nil
	self._isHero = false
	self._nameStr = ""

	if tonumber(showType) == 1 then
		self._roleId = data.masterId
		self._singleRole = self._masterSystem:getMasterById(data.masterId)
	else
		self._roleId = data.heroId
		self._singleRole = self._heroSystem:getHeroById(data.heroId)
		self._isHero = true
	end
end

function AttrInfoView:createPanelLayer()
	local winSize = cc.Director:getInstance():getWinSize()

	self._mainPanel = ccui.Layout:create()

	self._mainPanel:setContentSize(cc.size(winSize.width, winSize.height))
	self._mainPanel:setTouchEnabled(true)
	self._parent:addChild(self._mainPanel, 999999)
	self:showLayoutForTest(self._mainPanel, cc.c4b(0, 0, 0, 255))

	self._listView = ccui.ListView:create()

	self._listView:removeAllItems()
	self._mainPanel:addChild(self._listView)
	self._listView:setAnchorPoint(cc.p(0, 0))
	self._listView:setPosition(cc.p(120, 20))
	self._listView:setContentSize(cc.size(winSize.width - 200, winSize.height - 200))

	local closeBtn = ccui.Button:create(DebugBoxTool:getResPath("pic_dm_debug_ok_normal.png"), DebugBoxTool:getResPath("pic_dm_debug_ok_press.png"), "")

	closeBtn:setName("closeBtn")
	closeBtn:setScale(2)
	self._mainPanel:addChild(closeBtn, 0)
	closeBtn:setPosition(winSize.width - 100, winSize.height - 100)
	closeBtn:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			self._mainPanel:removeFromParent(true)
		end
	end)
end

function AttrInfoView:showLayoutForTest(layout, color)
	layout:setBackGroundColorType(1)
	layout:setBackGroundColor(color or cc.c3b(24, 255, 0))
	layout:setBackGroundColorOpacity(180)
end

function AttrInfoView:addSingleAttr(str, color, fontSize, closeLine)
	if not closeLine then
		str = str .. "\n-------------------------------------------------------------"
	end

	local newPanel = self:createDescPanel(str, color, fontSize)

	self._listView:pushBackCustomItem(newPanel)
end

function AttrInfoView:createDescPanel(title, colorNum, fontSize)
	local winSize = cc.Director:getInstance():getWinSize()

	fontSize = fontSize or 22

	local layout = ccui.Layout:create()
	local label = ccui.Text:create("", TTF_FONT_FZYH_M, fontSize)

	if colorNum then
		label:setTextColor(colorNum)
	end

	label:setAnchorPoint(cc.p(0.5, 0.5))
	label:getVirtualRenderer():setDimensions(winSize.width - 200, 0)
	label:setString(tostring(title))

	local height = label:getContentSize().height

	layout:setContentSize(cc.size(winSize.width - 200, height))
	label:addTo(layout):center(layout:getContentSize())

	return layout
end

local heroDescFactor = {
	"A",
	"B",
	"C",
	"D",
	"E",
	"F",
	"G",
	"H",
	"I",
	"J"
}
local baseResult = "(a * (1 + b) + c) * (1 + d) + f"
local rateResult = "a + b"

function AttrInfoView:createAttr()
	local attrFactor = self._singleRole:getAttrFactor()

	HeroAttribute._cache_res = {}

	local combat, attrData = self._singleRole:getCombat(self._evnType)
	local str1 = self._isHero and "英雄" or "主角"

	str1 = str1 .. ":" .. self._singleRole:getName() .. "         ID = " .. tostring(self._roleId) .. "          场景环境 = " .. tostring(self._evnType)

	self:addSingleAttr(str1, cc.c3b(210, 0, 0), 30)

	local str1 = "\n一. 总战斗力= " .. tostring(combat) .. "\n"

	self:addSingleAttr(str1, cc.c3b(0, 210, 0), 24)

	local str1 = "战斗力公式\n"

	if self._isHero then
		str1 = str1 .. HeroAttribute.heroCombatDesc .. "\n\n"

		for i, v in pairs(heroDescFactor) do
			str1 = str1 .. v .. " = " .. HeroAttribute.heroCombatValue[i] .. "\n"
		end
	else
		str1 = str1 .. "主角战斗力取自后端，前端不参与计算\n\n"
		str1 = str1 .. MasterAttribute.masterCombatDesc
	end

	self:addSingleAttr(str1)

	local str1 = "\n二. 每种属性总值\n"

	self:addSingleAttr(str1, cc.c3b(0, 210, 0), 24)

	local str1 = "\n每种属性参数组成说明：\n\n  1. 基础属性{攻防血}\n result= (a * (1 + b) + c) * (1 + d) + f \n [ a : 属性基础值 b : 百分比加成 c : 额外值加成 d : 环境百分比加成 f : 环境额外值加成] \n"

	str1 = str1 .. "\n  2. 概率属性\nresult= a + b\n [ a 值加成 b 额外值加成]\n\n"

	self:addSingleAttr(str1)

	local str1 = "**基础属性**\n"

	self:addSingleAttr(str1, cc.c3b(210, 0, 0), 24)

	local str1 = self:getStrByAttrType("HP", attrData.hp, "生命：")
	local str1 = self:getStrByAttrType("ATK", attrData.attack, "攻击：")
	local str1 = self:getStrByAttrType("DEF", attrData.defense, "防御：")
	local str1 = self:getStrByAttrType("CRITRATE", attrData.critRate, "暴击率：")
	local str1 = self:getStrByAttrType("UNCRITRATE", attrData.uncritRate, "抗暴率：")
	local str1 = self:getStrByAttrType("CRITSTRG", attrData.critStrg, "暴击强度：")
	local str1 = self:getStrByAttrType("BLOCKRATE", attrData.blockRate, "格挡率：")
	local str1 = self:getStrByAttrType("UNBLOCKRATE", attrData.unblockRate, "破击率：")
	local str1 = self:getStrByAttrType("BLOCKSTRG", attrData.blockStrg, "格挡强度：")
	local str1 = self:getStrByAttrType("HURTRATE", attrData.hurtRate, "伤害率：")
	local str1 = self:getStrByAttrType("UNHURTRATE", attrData.unhurtRate, "免伤率：")
	local str1 = self:getStrByAttrType("ABSORPTION", attrData.absorption, "吸血率：")
	local str1 = self:getStrByAttrType("REFLECTION", attrData.reflection, "反伤率：")
	local str1 = self:getStrByAttrType("EFFECTSTRG", attrData.effectStrg, "效果强度：")
	local str1 = self:getStrByAttrType("UNEFFECTRATE", attrData.unEffectRate, "效果抵抗：")
	local str1 = self:getStrByAttrType("EFFECTRATE", attrData.effectRate, "效果命中：")
end

local factors = {
	"a",
	"b",
	"c",
	"d",
	"e",
	"f"
}
local cjson = require("cjson.safe")

function AttrInfoView:getStrByAttrType(attrType, attrNum, attrName)
	local attrFactor = self._singleRole:getAttrFactor()
	local vector = attrFactor:getVector(attrType)

	attrName = attrName or ""

	local data = {}
	local serverAttr = {}

	if self._singleRole._attrs and self._singleRole._attrs.details then
		serverAttr = self._singleRole._attrs.details[attrType]
	end

	for i = 1, #serverAttr do
		local element = factors[i]

		data[element] = serverAttr[i]
	end

	local str = attrName .. attrType

	self:addSingleAttr(str, cc.c3b(210, 0, 0), nil, true)

	local vectorStr = tostring(attrNum) .. " = "
	local vectorNum = 0

	if AttributeCategory:isAttrBaseType(attrType) then
		vectorNum = (vector.a * (1 + vector.b) + vector.c) * (1 + vector.d) + vector.f
		vectorStr = vectorStr .. "{" .. baseResult .. ": " .. (vector.a * (1 + vector.b) + vector.c) * (1 + vector.d) + vector.f .. "}"
	else
		vectorStr = vectorStr .. "{" .. rateResult .. ": " .. vector.a + vector.b .. "}"
	end

	vectorStr = string.gsub(vectorStr, ":", " = ")
	vectorStr = string.gsub(vectorStr, ",", " , ")

	local effectAdd = " + {其他效果加成 : " .. self._singleRole:getAddAttrByType(attrType) .. "}"
	local str = vectorStr .. effectAdd .. "\n"

	self:addSingleAttr(str, nil, nil, true)

	local singleData = {}
	local singleEffectManger = self._singleRole:getEffectList()
	local effectList = singleEffectManger:getEffectList()

	self:createElementStr(effectList, singleData, attrType)

	local elementStr = cjson.encode(singleData)

	elementStr = string.gsub(elementStr, ":", " = ")
	elementStr = string.gsub(elementStr, ",", " ,\n ")
	elementStr = string.gsub(elementStr, "%!", "\n        ")

	local rangeData = {}
	local rangeEffectList = self._singleRole:getPlayer():getEffectList()
	local effectList = rangeEffectList:getEffectList()

	self:createRangeElementStr(effectList, rangeData, attrType)

	local rangeElementStr = cjson.encode(rangeData)

	rangeElementStr = string.gsub(rangeElementStr, ":", " = ")
	rangeElementStr = string.gsub(rangeElementStr, ",", " ,\n ")
	rangeElementStr = string.gsub(rangeElementStr, "%!", "\n        ")

	if not next(rangeData) then
		rangeElementStr = ""
	end

	if not next(singleData) and not next(rangeData) then
		elementStr = "\n该属性未有属性加成"
	end

	self:addSingleAttr(elementStr .. "\n" .. rangeElementStr, cc.c3b(255, 252, 0), nil)

	local effectStr = "其他效果加成：\n"

	if self._isHero then
		local num = self._singleRole:getGalleryAllAttrByType(attrType)

		if num > 0 then
			effectStr = effectStr .. "好感度通用加成 = " .. num .. "\n"
		end

		local num = self._singleRole:getBuildComfortEffectById(attrType)

		if num > 0 then
			effectStr = effectStr .. "城建舒适度加成 = " .. num .. "\n"
		end

		local num = self._singleRole:getMessageEffectById(attrType)

		if num > 0 then
			effectStr = effectStr .. "情报基础加成 = " .. num .. "\n"
		end

		local num = self._singleRole:getMessagePartyEffectById(self._singleRole:getParty(), attrType)

		if num > 0 then
			effectStr = effectStr .. "情报每5级特殊效果加成 = " .. num .. "\n"
		end

		local num = self._singleRole:getAuraEffectById(attrType)

		if num > 0 then
			effectStr = effectStr .. "英魂光环加成 = " .. num .. "\n"
		end

		local num = self._singleRole:getEquipAttrByType(attrType)

		if num > 0 then
			effectStr = effectStr .. "装备加成 = " .. num .. "\n"
		end

		local num = self._singleRole:getTimeEffectById(attrType)

		if num > 0 then
			effectStr = effectStr .. "计时BUFF = " .. num .. "\n"
		end
	end

	self:addSingleAttr(effectStr, cc.c3b(255, 252, 0), nil)

	return elementStr .. "\n"
end

function AttrInfoView:createElementStr(effectList, data, attrType)
	for effect, _ in pairs(effectList) do
		local effectFromName = effect._effectFromName

		effectFromName = "!" .. effectFromName

		for _, e in pairs((effect._getSubeffects or nil) and effect:_getSubeffects()) do
			local config = e:getConfig()
			local elementType = config.elementType

			if config.effectEvn ~= GameEnvType.kAll then
				if self._evnType then
					local evnOk = self._evnType == config.effectEvn
					local target = config.target
					local targetOk = target == "SELF" or target == RangeTargetType.ALL or self._isHero and target == RangeTargetType.HERO or not self._isHero and target == RangeTargetType.MASTER

					if config.attrType == attrType and evnOk and targetOk then
						data[elementType] = data[elementType] or {}

						local elementMap = data[elementType]

						elementMap[effectFromName] = elementMap[effectFromName] or 0
						elementMap[effectFromName] = elementMap[effectFromName] + config.attrNum
					end
				end
			end
		end
	end
end

function AttrInfoView:createRangeElementStr(effectList, data, attrType)
	for effect, _ in pairs(effectList) do
		local effectFromName = effect._effectFromName

		effectFromName = "!" .. effectFromName

		for _, e in pairs((effect._getSubeffects or nil) and effect:_getSubeffects()) do
			local config = e:getConfig()
			local elementType = config.elementType

			if config.effectEvn ~= GameEnvType.kAll then
				if self._evnType then
					local evnOk = self._evnType == config.effectEvn

					if config.attrType == attrType and evnOk then
						data[elementType] = data[elementType] or {}

						local elementMap = data[elementType]

						elementMap[effectFromName] = elementMap[effectFromName] or 0
						elementMap[effectFromName] = elementMap[effectFromName] + config.attrNum
					end
				end
			end
		end
	end
end
