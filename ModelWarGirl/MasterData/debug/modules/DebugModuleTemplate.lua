-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Debug\\Modules\\DebugModuleTemplate.lua

local DebugConst = require("Debug/DebugConst")
local RearHouseDragCenter = require("Logic/RearHouse/RearHouseDragCenter")
local UserData = require("Helper/UserData")
local ChannelUtil = require("SDK/ChannelUtil")
local DeviceHelper = require("Helper/DeviceHelper")
local DebugModule = {}

DebugModule.ENTRY_NAME = "测试"

function DebugModule.stepA(sender, menu, value)
	return
end

function DebugModule.stepB(sender, menu, value)
	return
end

function DebugModule.stepC(sender, menu, value)
	return
end

function DebugModule.stepD(sender, menu, value)
	return
end

function DebugModule.simulateNotch(sender, menu, value)
	UserData.saveCommonData(Const.UD_KEY_NOTCH_ADAPT, value)
	Framework.UI.UIUtils.SetAdaptConfig(tonumber(value))
end

function DebugModule.simulateBottomNotch(sender, menu, value)
	local isBottomNotch = not DeviceHelper._debugiPhoneWithNotch

	DeviceHelper._debugiPhoneWithNotch = isBottomNotch

	MsgManager.notice((isBottomNotch and "开启" or "关闭") .. "模拟底栏")
end

function DebugModule.setRearHousePreset(sender, menu, value)
	RearHouseDragCenter.setPreset(tonumber(value))
end

function DebugModule.testCircleBattleAni(sender, menu, value)
	local CircleControlCenter = require("Logic/Circle/CircleControlCenter")
	local id = tonumber(value)

	if id then
		if id == 1 then
			CircleControlCenter.testFence()
		elseif id == 2 then
			CircleControlCenter.testTrainOut()
		elseif id == 3 then
			CircleControlCenter.testTrainGo()
		else
			CircleControlCenter.testAni()
		end
	end
end

function DebugModule.testCircleBattleModelNum(sender, menu, value)
	local CircleControlCenter = require("Logic/Circle/CircleControlCenter")
	local s = utils.splitString(value, ",")

	if #s > 1 then
		local num = tonumber(s[1])
		local mdoelId = tonumber(s[2])

		CircleControlCenter.testModelNum(num, mdoelId)
	elseif #s == 1 then
		local num = tonumber(s[1])

		CircleControlCenter.testModelNum(num)
	end
end

function DebugModule.testCircleBattleModelLimitNum(sender, menu, value)
	local CircleControlCenter = require("Logic/Circle/CircleControlCenter")
	local num = tonumber(value)

	Const.CIRCLE_BATTLE_MAX_PLAYER_MODEL_NUM = num

	MsgManager.notice("设置模型限制数量为" .. num)
end

function DebugModule.relationGrow(sender, menu, value)
	local ResRoomHeroShow = require("ClientData/ResRoomHeroShow")
	local hero = BaseObject.GetObject(tonumber(value))

	hero.roomInfo = ResRoomHeroShow[hero.team][tonumber(value)]
	hero.isGeted = true
	hero.isRoomHero = true

	local heroShowRoomGrowUpDlg = UIManager.getUI("heroShowRoomGrowUpDlg", true)

	heroShowRoomGrowUpDlg:setRoomHero(hero)
end

function DebugModule.relationLine()
	local heroShowRoomListDlg = UIManager.getUI("heroShowRoomListDlg", true)

	heroShowRoomListDlg:setRoomHeroList(CurAvatar:getRoomHeroListDic(), 1)
end

function DebugModule.writeRelationPosInfo()
	local posInfoList = {}
	local heroShowRoomListDlg = UIManager.getUI("heroShowRoomListDlg", nil, false)

	if heroShowRoomListDlg and heroShowRoomListDlg.curPage then
		local obj = heroShowRoomListDlg.curPage.panelHero:getComObj()

		if obj ~= nil then
			local labelType = typeof(UnityEngine.UI.Text)
			local ResHero = require("ClientData/ResHero")
			local nameIdDic = {}

			for heroId, resData in pairs(ResHero) do
				nameIdDic[resData.hero_name] = heroId
			end

			for i = 1, obj.transform.childCount do
				local child = obj.transform:GetChild(i - 1)

				if string.find(child.name, "GridHeroShowRoom") then
					local posInfo = {}

					posInfo.pos = {
						child.localPosition.x,
						child.localPosition.y
					}

					local nameTrans = child:Find("NmlPanel/TextName")
					local labelCom = nameTrans:GetComponent(labelType)
					local heroName = labelCom.text

					posInfo.heroName = heroName
					posInfo.heroId = nameIdDic[heroName] ~= nil and nameIdDic[heroName] or "该名字找不到ID"

					table.insert(posInfoList, posInfo)
				end
			end
		end
	end

	for _, posInfo in ipairs(posInfoList) do
		-- block empty
	end

	local file = io.open("RelationPosInfo" .. os.date("%m-%d-%H_%M_%S", ClientUtils.getServerTime()) .. ".csv", "w+")
	local output = ""

	for i, posInfo in ipairs(posInfoList) do
		local lineStr = string.format("%s,%s,%s\n", posInfo.heroName, posInfo.heroId, posInfo.pos[1] .. ";" .. posInfo.pos[2])

		output = output .. lineStr
	end

	file:write(output)
	file:flush()
	file:close()
end

function DebugModule.relationMain(sender, menu, value)
	local heroShowRoomMainDlg = UIManager.getUI("heroShowRoomMainDlg", nil, false)

	if heroShowRoomMainDlg then
		local teamList = utils.splitString(value, ",")
		local teamDic = {}

		for _, teamId in ipairs(teamList) do
			teamDic[tonumber(teamId)] = 1
		end

		heroShowRoomMainDlg:playNewStageEfx(teamDic)
	end
end

function DebugModule.openActivityCollectWordsComposeDlg(sender, menu, value)
	local activityCollectWordsComposeDlg = UIManager.getUI("activityCollectWordsComposeDlg", nil, false)

	if activityCollectWordsComposeDlg then
		activityCollectWordsComposeDlg:setVisible(false)
	else
		UIManager.getUI("activityCollectWordsComposeDlg", true)
	end
end

DebugModule.FUNC_MENU = {
	{
		name = "步骤1",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.stepA
	},
	{
		name = "步骤2",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.stepB
	},
	{
		name = "步骤3",
		typ = DebugConst.BTN_TYPE_MENU,
		value = {
			{
				name = "步骤3-1",
				typ = DebugConst.BTN_TYPE_CHECKBOX,
				func = DebugModule.stepC
			},
			{
				name = "步骤3-2",
				typ = DebugConst.BTN_TYPE_COMBOX,
				func = DebugModule.stepD,
				value = {
					2,
					1,
					0
				}
			}
		}
	},
	{
		name = "模拟刘海屏",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.simulateNotch
	},
	{
		name = "模拟iPhoneX底栏",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.simulateBottomNotch
	},
	{
		name = "后宅预设组",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.setRearHousePreset
	},
	{
		name = "测试公会战动画",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.testCircleBattleAni
	},
	{
		name = "测试公会战模型数量",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.testCircleBattleModelNum
	},
	{
		name = "公会战模型限制数量",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.testCircleBattleModelLimitNum
	},
	{
		name = "打开集字合成界面",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.openActivityCollectWordsComposeDlg
	},
	{
		name = "输出羁绊位置信息",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.writeRelationPosInfo
	}
}

return DebugModule
