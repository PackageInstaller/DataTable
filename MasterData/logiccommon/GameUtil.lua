-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/util/GameUtil.lua

module("logiccommon.common.util.GameUtil", package.seeall)

local GameUtil = {}
local checknumber = checknumber
local skeletonAnimationType = typeof(Spine.Unity.SkeletonAnimation)

GameUtil.emptyTable = {}
GameUtil.json = require("cjson")
GameUtil.goods_color_list = {
	[0] = "#939393",
	"#20b376",
	"#0083e7",
	"#df5bff",
	"#cd7800",
	"#eb4642"
}
GameUtil.astro = {
	"摩羯座",
	"水瓶座",
	"双鱼座",
	"白羊座",
	"金牛座",
	"双子座",
	"巨蟹座",
	"狮子座",
	"处女座",
	"天秤座",
	"天蝎座",
	"射手座",
	"摩羯座"
}
GameUtil.astroSplitDays = {
	20,
	19,
	21,
	21,
	21,
	22,
	23,
	23,
	23,
	23,
	22,
	22
}
GameUtil.ForeverActTimeString = "2038-01-18T05:00:00"
GameUtil.ForeverActTimeStringStamp = 2147374800

function tableMO(super)
	local M = {}

	if super then
		M.__index = super
		M.__newindex = super.__newindex
	else
		M.__index = M

		function M.__newindex(t, key, value)
			if type(value) == "userdata" or type(value) == "function" then
				error("tableMO instance object field not support userdata or function,key=" .. key)
			else
				rawset(t, key, value)
			end
		end
	end

	function M.ctor(object)
		return
	end

	function M.New()
		local object = {}

		M.ctor(object)
		setmetatable(object, M)

		return object
	end

	setmetatable(M, {
		__newindex = function(t, key, value)
			if type(value) ~= "function" then
				error("tableMO table only support function!key=" .. key)
			else
				rawset(t, key, value)
			end
		end
	})

	return M
end

setglobal("tableMO", tableMO)

function GameUtil.isFunction(f)
	return type(f) == "function"
end

function GameUtil.isTable(value)
	return type(value) == "table"
end

function GameUtil.isNumber(value)
	return type(value) == "number"
end

function GameUtil.isString(value)
	return type(value) == "string"
end

function GameUtil.isEmptyString(str)
	if str == nil or GameUtil.isString(str) and string.gsub(str, "^%s*(.-)%s*$", "%1") == "" then
		return true
	end

	return false
end

function GameUtil.isU3DEditor()
	return Framework.OSDef.isEditor
end

function GameUtil.lineSegmentIntersection(p1, p2, p3, p4)
	local a = p2 - p1
	local b = p3 - p4
	local c = p1 - p3
	local alphaNumerator = b.y * c.x - b.x * c.y
	local alphaDenominator = a.y * b.x - a.x * b.y
	local betaNumerator = a.x * c.y - a.y * c.x
	local betaDenominator = alphaDenominator
	local c1 = a.y * p1.x - a.x * p1.y
	local c2 = b.x * p3.y - b.y * p3.x
	local doIntersect = true

	if alphaDenominator == 0 or betaDenominator == 0 then
		doIntersect = false
	else
		if alphaDenominator > 0 then
			if alphaNumerator < 0 or alphaDenominator < alphaNumerator then
				doIntersect = false
			end
		elseif alphaNumerator > 0 or alphaNumerator < alphaDenominator then
			doIntersect = false
		end

		if doIntersect and betaDenominator > 0 then
			if betaNumerator < 0 or betaDenominator < betaNumerator then
				doIntersect = false
			end
		elseif betaNumerator > 0 or betaNumerator < betaDenominator then
			doIntersect = false
		end
	end

	if doIntersect then
		local delta = a.y * b.x - b.y * a.x

		return true, Vector2.New((b.x * c1 + a.x * c2) / delta, (a.y * c2 + b.y * c1) / delta)
	end

	return false
end

function GameUtil.getCurveMovePoints(startPos, targetPos, height)
	local tlPoints = {}
	local centerPos = (startPos + targetPos) * 0.5

	centerPos.y = centerPos.y + height * math.sin(0.5 * math.pi)

	table.insert(tlPoints, startPos)
	table.insert(tlPoints, centerPos)
	table.insert(tlPoints, targetPos)

	return tlPoints
end

function GameUtil.setLocalString(key, value)
	Framework.LocalStorage.Instance:SetString(key, value)
end

function GameUtil.getLocalString(key, defValue)
	return Framework.LocalStorage.Instance:GetString(key, defValue or "")
end

function GameUtil.setLocalFloat(key, value)
	Framework.LocalStorage.Instance:SetFloat(key, value)
end

function GameUtil.getLocalFloat(key, defValue)
	return Framework.LocalStorage.Instance:GetFloat(key, defValue or 0)
end

function GameUtil.playAudioEffect(url, handler, handlerTarget)
	Framework.AudioMgr.Instance.EffectVolume = PlayerSettingModel.instance:getVolume(PlayerSettingModel.audioKeyEnum.typeSound)

	Framework.AudioMgr.Instance:PlayEffect(url, handler, handlerTarget)
end

function GameUtil.playAudioById(audioId, handler, handlerTarget)
	local url = CommonConfig.instance:getAudioFilePathById(audioId)

	GameUtil.playAudioEffect(url, handler, handlerTarget)
end

function GameUtil.stopAudioEffect(url)
	Framework.AudioMgr.Instance:StopEffect(url)
end

function GameUtil.getWidth(go)
	local trans = go.gameObject:GetComponent(goutil.Type_RectTransform)

	if trans then
		return goutil.getWidth(trans)
	end
end

function GameUtil.setWidth(go, width)
	local trans = go.gameObject:GetComponent(goutil.Type_RectTransform)

	if trans then
		goutil.setWidth(trans, width)
	end
end

function GameUtil.getHeight(go)
	local trans = go.gameObject:GetComponent(goutil.Type_RectTransform)

	if trans then
		return goutil.getHeight(trans)
	end
end

function GameUtil.setHeight(go, height)
	local trans = go.gameObject:GetComponent(goutil.Type_RectTransform)

	if trans then
		goutil.setHeight(trans, height)
	end
end

function GameUtil.getAnchoredPos(go)
	if go then
		local x, y, z = Framework.TransformUtil.GetAnchoredPos(go.transform, 0, 0)

		return Vector2.New(x, y)
	end
end

function GameUtil.setAnchoredPos(go, x, y)
	if goutil.isNil(go.gameObject) == false then
		Framework.TransformUtil.SetAnchoredPos(go.gameObject.transform, x, y)
	end
end

function GameUtil.getLocalPos(go)
	if go then
		local x, y, z = Framework.TransformUtil.GetLocalPos(go.transform, 0, 0, 0)

		return Vector3.New(x, y, z)
	end
end

function GameUtil.setLocalPos(go, x, y, z)
	if goutil.isNil(go) == false then
		z = z or 0

		Framework.TransformUtil.SetLocalPos(go.transform, x, y, z)
	end
end

function GameUtil.getLocalRotation(go)
	if go then
		local x, y, z = Framework.TransformUtil.GetLocalRotation(go.transform, 0, 0, 0)

		return x, y, z
	end
end

function GameUtil.setLocalRotation(go, x, y, z)
	if goutil.isNil(go) == false then
		z = z or 0

		Framework.TransformUtil.SetLocalRotation(go.transform, x, y, z)
	end
end

function GameUtil.getPos(go)
	if go and not goutil.isNil(go) then
		local x, y, z = Framework.TransformUtil.GetPos(go.transform, 0, 0, 0)

		return Vector3.New(x, y, z)
	end
end

function GameUtil.setPos(go, x, y, z)
	if goutil.isNil(go) == false then
		z = z or 0

		Framework.TransformUtil.SetPos(go.transform, x, y, z)
	end
end

function GameUtil.setLocalScale(go, scaleX, scaleY, scaleZ)
	scaleX = scaleX or 1
	scaleY = scaleY or scaleX
	scaleZ = scaleZ or 1

	if goutil.isNil(go) == false then
		Framework.TransformUtil.SetLocalScale(go.transform, scaleX, scaleY, scaleZ)
	end
end

function GameUtil.getLocalScale(go)
	if not goutil.isNil(go) then
		local x, y, z = Framework.TransformUtil.GetLocalScale(go.transform, 0, 0, 0)

		return Vector3.New(x, y, z)
	end
end

function GameUtil.rotaPointToPointWithAngle(disPoint, toPoint, axis, angle)
	local point = Quaternion.AngleAxis(angle, axis) * (disPoint - toPoint)

	return toPoint + point
end

function GameUtil.propToList(arr)
	local list = {}

	if arr then
		local obj = {}

		for i, v in ipairs(arr) do
			if not string.nilorempty(v) then
				local props = string.split(v, "#")

				for j, p in ipairs(props) do
					local op = 1
					local temArr

					if string.find(p, "-") then
						op = -1
						temArr = string.split(p, "-")
					else
						temArr = string.split(p, "+")
					end

					local key = temArr[1]
					local value = checknumber(temArr[2]) * op

					obj[key] = obj[key] == nil and value or obj[key] + value
				end
			end
		end

		for k, v in pairs(obj) do
			table.insert(list, {
				name = k,
				value = v
			})
		end
	end

	return list
end

function GameUtil.getUIChangeGroup(target)
	return target.gameObject:GetComponent("UIChangeGroup")
end

function GameUtil.setUIGroupIdx(target, idx)
	if target and target.gameObject then
		local com = GameUtil.getUIChangeGroup(target)

		if com then
			com:SetState(idx)
		end
	end
end

function GameUtil.getUIImageSpriteChange(target)
	if target then
		return target.gameObject:GetComponent("UIImageSpriteChange")
	end
end

function GameUtil.setUIImageSpriteIdx(target, idx)
	if target and target.gameObject then
		local com = GameUtil.getUIImageSpriteChange(target)

		if com then
			com:SetState(idx)
		end
	end
end

function GameUtil.getUIImageColorChange(target)
	return target.gameObject:GetComponent("UIImageColorChange")
end

function GameUtil.setUIImageColorIdx(target, idx)
	if target and target.gameObject then
		local com = GameUtil.getUIImageColorChange(target)

		if com then
			com:SetState(idx)
		end
	end
end

function GameUtil.getUITextColorChange(target)
	return target.gameObject:GetComponent("UITextColorChange")
end

function GameUtil.setUITextColorIdx(target, idx)
	if target and target.gameObject then
		local com = GameUtil.getUITextColorChange(target)

		if com then
			com:SetState(idx)
		end
	end
end

function GameUtil.getCullingSprite(container, childName)
	return CullingSpriteLoad.GetFrom(container, childName)
end

function GameUtil.setCullingSprite(cullingSprite, url, callback, targetObj, cullingSpriteParams)
	if goutil.isNil(cullingSprite) then
		return
	end

	local tlParams = {}

	if cullingSpriteParams and type(cullingSpriteParams) == "string" then
		tlParams = string.split(cullingSpriteParams, "#")
	else
		print("cullingSpriteParams is nil or cullingSpriteParams is not string")
	end

	if #tlParams >= 3 then
		for i = 1, #tlParams do
			tlParams[i] = tonumber(tlParams[i])
		end

		cullingSprite:SetImage(url, callback, targetObj, Vector2.New(tlParams[1], tlParams[2]), tlParams[3])
	else
		print("cullingSpriteParams not inculde 3 params")
	end
end

function GameUtil.isBitOpenByDigit(num, digit)
	local shiftedNum = bit.rshift(num, digit)

	return bit.band(shiftedNum, 1) ~= 0
end

function GameUtil.setBitByDigit(num, digit)
	local shiftedNum = bit.lshift(1, digit)

	return bit.bor(shiftedNum, num)
end

function GameUtil.setBitByDigitXor(num, digit)
	local shiftedNum = bit.lshift(1, digit)

	return bit.bxor(shiftedNum, num)
end

function GameUtil.reverse(tb)
	for i = 1, math.floor(#tb / 2) do
		tb[i] = tb[#tb - i + 1]
		tb[#tb - i + 1] = tb[i]
	end

	return tb
end

function GameUtil.setGameObjsPosWithCenterSort(GoList, nShowCount, spaceDis)
	if GoList and #GoList > 0 then
		local nCellWidth, startPosX, _nShowCount, _spaceDis = 0, 0, nShowCount or 0, spaceDis or 0
		local rectItem = GoList[1]:GetComponent("RectTransform")

		if rectItem then
			nCellWidth = goutil.getWidth(rectItem)
		end

		if nCellWidth > 0 then
			local startPosX = math.max(0, (_nShowCount - 1) * nCellWidth + math.max(0, _nShowCount - 1) * _spaceDis) * -0.5
			local itemPos, posX

			for i = 1, #GoList do
				goutil.setActive(GoList[i], i <= _nShowCount)

				if i <= _nShowCount then
					itemPos = GameUtil.getLocalPos(GoList[i])

					GameUtil.setLocalPos(GoList[i], startPosX + (i - 1) * (nCellWidth + _spaceDis), itemPos.y, itemPos.z)
				end
			end
		else
			printInfo("nCellWidth == 0")
		end
	end
end

function GameUtil.getReverseTable(dataList)
	if not dataList or not GameUtil.isTable(dataList) then
		return dataList
	end

	local reverseList = {}

	for i = #dataList, 1, -1 do
		table.insert(reverseList, dataList[i])
	end

	return reverseList
end

function GameUtil.getStrLen(str)
	if GameUtil.isEmptyString(str) then
		return 0
	end

	local count = #str
	local strLen = 0

	for i = 1, count do
		local byte = string.byte(str, i)

		if byte > 0 and byte <= 127 then
			strLen = strLen + 1
		elseif byte >= 192 and byte <= 239 then
			strLen = strLen + 2
			i = i + 2
		end
	end

	return strLen
end

function GameUtil.getChineseNum(str)
	if GameUtil.isEmptyString(str) then
		return 0
	end

	local count = #str
	local strLen = 0

	for i = 1, count do
		local byte = string.byte(str, i)

		if byte >= 192 and byte <= 239 then
			strLen = strLen + 1
			i = i + 2
		end
	end

	return strLen
end

function GameUtil.filter_spec_chars(s)
	local ss = {}
	local k = 1

	while true do
		if k > #s then
			break
		end

		local c = string.byte(s, k)

		if not c then
			break
		end

		if c < 192 then
			if c >= 48 and c <= 57 or c >= 65 and c <= 90 or c >= 97 and c <= 122 then
				table.insert(ss, string.char(c))
			end

			k = k + 1
		elseif c < 224 then
			k = k + 2
		elseif c < 240 then
			if c >= 228 and c <= 233 then
				local c1 = string.byte(s, k + 1)
				local c2 = string.byte(s, k + 2)

				if c1 and c2 then
					local a1, a2, a3, a4 = 128, 191, 128, 191

					if c == 228 then
						a1 = 184
					elseif c == 233 then
						a2, a4 = 190, c1 ~= 190 and 191 or 165
					end

					if a1 <= c1 and c1 <= a2 and a3 <= c2 and c2 <= a4 then
						table.insert(ss, string.char(c, c1, c2))
					end
				end
			end

			k = k + 3
		elseif c < 248 then
			k = k + 4
		elseif c < 252 then
			k = k + 5
		elseif c < 254 then
			k = k + 6
		end
	end

	return table.concat(ss)
end

function GameUtil.getBriefName(itemName, charCount)
	local itemNameCount = GameUtil.getStrLen(itemName)

	charCount = charCount or 18

	if itemNameCount > 12 then
		local briefNamePrefix = string.sub(itemName, 1, charCount)

		return briefNamePrefix .. "..."
	else
		return itemName
	end
end

function GameUtil.getPrefixFiveName(itemName, charCount)
	local itemNameCount = GameUtil.getStrLen(itemName)

	charCount = charCount or 15

	if itemNameCount > 10 then
		local briefNamePrefix = string.sub(itemName, 1, charCount)

		return briefNamePrefix .. "..."
	else
		return itemName
	end
end

function GameUtil.getUCharList(ucharStr)
	if GameUtil.isEmptyString(ucharStr) then
		return
	end

	local ucharList = {}

	for uchar in string.gmatch(ucharStr, "[%z\x01-\x7F\xC2-\xF4][\x80-\xBF]*") do
		if GameUtil.isEmptyString(uchar) == false then
			table.insert(ucharList, uchar)
		end
	end

	return ucharList
end

function GameUtil.checkInput(inputTxt)
	inputTxt = string.gsub(inputTxt, "　", "")

	return string.gsub(inputTxt, "[ \t\n\r]+", "")
end

function GameUtil.checkIsContainPunctuation(str)
	if GameUtil.isEmptyString(str) then
		return false
	end

	local count = #str
	local k = 1

	for i = 1, count do
		local byte = string.byte(str, k)

		if byte then
			if byte >= 48 and byte <= 57 or byte >= 65 and byte <= 90 or byte >= 97 and byte <= 122 then
				k = k + 1
			elseif byte >= 228 and byte <= 233 then
				k = k + 3
			else
				return true
			end
		end
	end

	return false
end

function GameUtil.parseItemStr(itemStr)
	if GameUtil.isEmptyString(itemStr) then
		return
	end

	local itemTb = string.split(itemStr, "#")
	local itemList = {}

	for i = 1, #itemTb do
		if GameUtil.isEmptyString(itemTb[i]) == false then
			local item = string.split(itemTb[i], ":")
			local itemType = tonumber((not item[1] or nil) and 1)
			local itemId = tonumber((not item[2] or nil) and 10000000)
			local count = tonumber((not item[3] or nil) and 1)

			table.insert(itemList, {
				itemType = itemType,
				itemId = itemId,
				count = count
			})
		end
	end

	return itemList
end

function GameUtil.getChineseNumber(number)
	number = number or 0

	if number >= 1000 then
		return number
	end

	local chineseNum = ""

	if number <= 10 then
		chineseNum = ConstString.ChineseNumber[number]
	elseif number > 10 and number < 100 then
		local tens = math.floor(number / 10)
		local units = number % 10

		if tens > 1 then
			if not ConstString.ChineseNumber[tens] then
				local value = ""

				chineseNum = units == 0 and value .. ConstString.ChineseNumber[10] or value .. ConstString.ChineseNumber[10] .. ConstString.ChineseNumber[units]
			end
		end
	elseif number >= 100 and number < 1000 then
		local hundreds = math.floor(number / 100)

		chineseNum = ConstString.ChineseNumber[hundreds] .. ConstString.ChineseNumber[100]

		local tens = math.floor(number % 100 / 10)
		local units = number % 10

		if tens == 0 and units == 0 then
			return chineseNum
		end

		chineseNum = tens == 0 and chineseNum .. ConstString.ChineseNumber[0] .. ConstString.ChineseNumber[units] or units == 0 and chineseNum .. ConstString.ChineseNumber[tens] .. ConstString.ChineseNumber[10] or chineseNum .. ConstString.ChineseNumber[tens] .. ConstString.ChineseNumber[10] .. ConstString.ChineseNumber[units]
	end

	return chineseNum
end

function GameUtil.getRaycastInfo(pos, camera)
	local unRaycast = camera and camera.cullingMask == Framework.LayerUtil.GetLayerMask(SceneLayer.Nothing)

	if unRaycast then
		return
	end

	local ray = camera:ScreenPointToRay(pos)
	local hitInfo
	local isClick, info = UnityEngine.Physics.Raycast(ray, hitInfo)

	if isClick and info then
		return info
	end
end

function GameUtil.isPadScreen(orthographicCamera)
	local screenW, screenH = UnityEngine.Screen.width, UnityEngine.Screen.height
	local perCurRatio = screenW / screenH

	if perCurRatio - 1.3333333333333333 < 0.01 then
		return true, orthographicCamera and 8 or 8, 75.2
	elseif perCurRatio - 1.6 < 0.01 then
		return true, orthographicCamera and 6.5 or 2, 65.4
	elseif perCurRatio - 1.6666666666666667 < 0.01 then
		return true, orthographicCamera and 6.5 or 1, 63.25
	end
end

function GameUtil.setUIBgAdaptive(uiObj, uiWidth, uiHeight)
	local rectTransform = ViewMgr.instance:getUICanvas():GetComponent("RectTransform")
	local screenW = rectTransform.sizeDelta.x
	local screenH = rectTransform.sizeDelta.y

	if screenW == 0 then
		screenW = UnityEngine.Screen.width
	end

	if screenH == 0 then
		screenH = UnityEngine.Screen.height
	end

	screenW = Mathf.Ceil(screenW)
	screenH = Mathf.Ceil(screenH)

	local detlaW = Mathf.Abs(uiWidth - screenW)
	local detlaH = Mathf.Abs(uiHeight - screenH)
	local ratioX
	local ignoreDetla = 2

	if ignoreDetla < detlaW and screenW < uiWidth or detlaW >= 0 and detlaW <= ignoreDetla then
		if ignoreDetla < detlaH and screenH < uiHeight then
			ratioX = detlaW / uiWidth

			GameUtil.setLocalScale(uiObj, 1 - detlaW / uiWidth, 1 - detlaW / uiWidth, 1 - detlaW / uiWidth)
		elseif ignoreDetla < detlaH and uiHeight < screenH then
			ratioX = detlaH / uiHeight

			GameUtil.setLocalScale(uiObj, 1, 1, 1)
		else
			GameUtil.setLocalScale(uiObj, 1, 1, 1)
		end
	elseif ignoreDetla < detlaW and uiWidth < screenW then
		GameUtil.setLocalScale(uiObj, screenW / uiWidth, screenW / uiWidth, screenW / uiWidth)
	else
		GameUtil.setLocalScale(uiObj, 1, 1, 1)
	end
end

function GameUtil.setWorldTo2DCameraPos(gameObj, pos, offsetPos, camera)
	if gameObj and pos then
		if offsetPos then
			pos = pos + offsetPos
		end

		camera = camera or CameraTargetMgr.instance:getMainCameraTarget():getCamera()

		local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()
		local _, screenPos = Framework.GeometryUtil.WorldTo2DCameraPoint(pos, camera, gameObj.transform, uiCamera, Vector3.zero, screenPos)

		Framework.TransformUtil.SetPos(gameObj.transform, screenPos.x, screenPos.y, screenPos.z)
	end
end

function GameUtil.get3DWorldPosFromScreen(screenPos, camera, refGOWorldPos)
	camera = camera or CameraTargetMgr.instance:getMainCameraTarget():getCamera()

	return (Framework.GeometryUtil.ScreenTo3DWorldPoint(screenPos, camera, refGOWorldPos))
end

function GameUtil.trycall(func, ...)
	local args = ...

	if args ~= nil then
		args = {
			...
		}

		return xpcall(function()
			func(unpack(args, 1), unpack(args, 2, #args))
		end, __G__TRACKBACK__)
	else
		return xpcall(func, __G__TRACKBACK__)
	end
end

function GameUtil.getConstrainSliderValue(curValue, valueList, maxSliderValue, endStepue)
	if valueList == nil or #valueList == 0 then
		print("valueList is nil")

		return 0
	end

	curValue = curValue or 0
	maxSliderValue = maxSliderValue or 1
	endStepue = endStepue or 0

	if curValue >= math.max(valueList[#valueList], endStepue) then
		return 1
	else
		local tempValue = 0

		if endStepue > valueList[#valueList] and curValue < valueList[#valueList] then
			local idx = 0

			for i = 1, #valueList do
				if curValue <= valueList[i] then
					idx = i - 1

					break
				end
			end

			return (idx + (idx > 0 and (curValue - valueList[idx]) / (valueList[idx + 1] - valueList[idx]) or curValue / valueList[idx + 1])) / #valueList * maxSliderValue
		else
			tempValue = (curValue - valueList[#valueList]) / (endStepue - valueList[#valueList]) * (1 - maxSliderValue)

			return (curValue - valueList[#valueList]) / (endStepue - valueList[#valueList]) * (1 - maxSliderValue) + maxSliderValue
		end
	end
end

function GameUtil.playLive2DMotionByConfig(live2dPerson, motion)
	if not live2dPerson then
		return
	end

	local defaultStr = "idle.mtn"

	if not motion then
		live2dPerson:playMotion(live2dPerson.modelId, defaultStr, 0, defaultStr)
	else
		local motionStr = string.split(motion, "#")

		if not GameUtil.isEmptyString(motionStr[1]) then
			local motionStrTb = string.split(motionStr[1], "/")

			if motionStrTb[#motionStrTb] == defaultStr then
				live2dPerson:playMotion(live2dPerson.modelId, defaultStr, 0, defaultStr)
			else
				live2dPerson:playMotion(live2dPerson.modelId, motionStrTb[#motionStrTb], 0, defaultStr)
			end
		end

		if not GameUtil.isEmptyString(motionStr[2]) then
			local multiExps = string.split(motionStr[2], "&")

			for i = 1, #multiExps do
				local expConf = multiExps[i]
				local durConf = string.split(expConf, "|")
				local expressionStrTb = string.split(durConf[1], "/")
				local fadeInTime = tonumber((not durConf[2] or nil) and 0)
				local time = tonumber((not durConf[3] or nil) and 2)
				local fadeOutTime = tonumber((not durConf[4] or nil) and 0)

				live2dPerson.live2dAnimation:addExpToPlayList(expressionStrTb[1], expressionStrTb[#expressionStrTb], time, fadeInTime, fadeOutTime)
			end
		end
	end
end

function GameUtil.getValueOrPercent(value)
	if value < 1 and value > 0 then
		return GameUtil.getMillesimalStr(value * 1000)
	else
		return value
	end
end

function GameUtil.getMillesimalStr(num)
	if num == nil then
		printError("num is nil")

		return ""
	end

	num = checknumber(num)

	if num % 10 ~= 0 then
		return string.format("%.1f%%", num * 0.1)
	else
		return string.format("%d%%", num * 0.1)
	end
end

function GameUtil.getAttrValue(key, value)
	if type(key) == "number" then
		key = GameEnum.AttrName[key]
	end

	if key == "critic" or key == "critic_dmg" or key == "dodge" then
		return GameUtil.getMillesimalStr(value)
	else
		return value
	end
end

function GameUtil.unloadResource(res, dependency)
	if dependency == nil then
		dependency = true
	end

	if res.RefCount == 1 then
		if dependency then
			local dependencies = res:GetDependencies()

			Framework.ResourceCache.Instance:DestroyResource(res)

			if dependencies then
				local cnt = dependencies.Count

				for i = 0, cnt - 1 do
					GameUtil.unloadResource(dependencies[i])
				end
			end
		else
			Framework.ResourceCache.Instance:DestroyResource(res)
		end
	end
end

function GameUtil.unloadResourceByName(resName, dependency)
	local res = Framework.ResourceCache.Instance:GetResourceNoLoadIfNotExists(resName)

	if res then
		GameUtil.unloadResource(res, dependency)
	end
end

function GameUtil.unloadMultiResLoaderResource(loader, dependency)
	if loader then
		local reses = loader:getResources()

		loader:clear()

		if reses then
			for k, v in pairs(reses) do
				GameUtil.unloadResource(v, dependency)
			end
		end
	end
end

function GameUtil.splitRaceTypes(race)
	return (string.split(race, ","))
end

function GameUtil.isInFrustum(x, y)
	local minX, minY, maxX, maxY = GameUtil.getCameraBoundingBox(x, y)

	if x < minX or maxX < x or y < minY or maxY < y then
		return
	end

	return true
end

function GameUtil.getCameraBoundingBox()
	local mainCamera = CameraTargetMgr.instance:getMainCameraTarget()
	local mainCam = mainCamera:getCamera()
	local camHalfSizeH = mainCam.orthographicSize * 1.5
	local camHalfSizeW = mainCam.aspect * camHalfSizeH
	local camPosX, camPosY = Framework.TransformUtil.GetPos(mainCam.transform, nil, nil, nil)
	local minX = camPosX - camHalfSizeW
	local maxX = camPosX + camHalfSizeW
	local minY = camPosY - camHalfSizeH
	local maxY = camPosY + camHalfSizeH

	return minX, minY, maxX, maxY
end

function GameUtil.findChildEx(go, childName)
	local child = goutil.findChild(go, childName)

	if child then
		return child
	end

	local childCnt = go.transform.childCount - 1

	for i = 0, childCnt do
		child = GameUtil.findChildEx(go.transform:GetChild(i), childName)

		if child then
			return child
		end
	end

	return nil
end

function GameUtil.calculateTextLinesNum(text)
	local height = text.preferredHeight
	local lineSpacing = text.fontSize * text.lineSpacing * 1.5

	return (math.ceil(height / lineSpacing))
end

function GameUtil.getTimeDifference(now, old)
	local now_tbl = os.date("*t", now)
	local old_tbl = os.date("*t", old)
	local year_temp = now_tbl.year - old_tbl.year

	if year_temp > 0 then
		return year_temp .. "年"
	end

	local month_temp = now_tbl.month - old_tbl.month

	if month_temp > 0 then
		return month_temp .. "月"
	end

	local day_temp = now_tbl.yday - old_tbl.yday

	if day_temp > 0 then
		return day_temp .. "天"
	end

	local hour_temp = now_tbl.hour - old_tbl.hour

	if hour_temp > 0 then
		return hour_temp .. "小时"
	end

	local minute_temp = now_tbl.min - old_tbl.min

	if minute_temp > 0 then
		return minute_temp .. "分"
	end

	local sec_temp = now_tbl.sec - old_tbl.sec

	if sec_temp > 0 then
		return "1分"
	end

	return "1分"
end

local IS_UNITY_CACHE_ENABLE_KEY = "IS_UNITY_CACHE_ENABLE_KEY"

function GameUtil.isUnityCacheEnable()
	local status = Framework.LocalStorage.Instance:GetInt(IS_UNITY_CACHE_ENABLE_KEY, -1)

	if status == 0 then
		return false
	else
		return true
	end
end

function GameUtil.setUnityCacheEnable(enable)
	Framework.LocalStorage.Instance:SetInt(IS_UNITY_CACHE_ENABLE_KEY, enable and 1 or 0)
	Framework.ResourceCache.Instance:EnableUnityCachingSystem(enable)
end

function GameUtil.repair()
	Framework.ResourceCache.Instance:ClearCaching()
	Framework.HotUpdate.VersionMgr.Instance:DeleteAllLocal()
end

function GameUtil.getWidgetCenterPosition(rectTrans)
	local pivot = rectTrans.pivot
	local sizeDelta = rectTrans.sizeDelta
	local pivotX = pivot.x - 0.5
	local pivotY = pivot.y - 0.5
	local localPosX, localPosY, localPosZ = Framework.TransformUtil.GetLocalPos(rectTrans, nil, nil, nil)

	Framework.TransformUtil.SetLocalPos(rectTrans, localPosX - sizeDelta.x * pivotX, localPosY - sizeDelta.y * pivotY, localPosZ)

	local x, y, z = Framework.TransformUtil.GetPos(rectTrans, nil, nil, nil)

	Framework.TransformUtil.SetLocalPos(rectTrans, localPosX, localPosY, localPosZ)

	return x, y, z
end

function GameUtil.getBounds(x0, y0, z0, x1, y1, z1, bounds)
	bounds = bounds or {}
	bounds.minX = math.min(x0, x1)
	bounds.maxX = math.max(x0, x1)
	bounds.minY = math.min(y0, y1)
	bounds.maxY = math.max(y0, y1)
	bounds.minZ = math.min(z0, z1)
	bounds.maxZ = math.max(z0, z1)

	return bounds
end

function GameUtil.isBoundsContains(bounds, x, y, z)
	if x < bounds.minX then
		return
	end

	if x > bounds.maxX then
		return
	end

	if y < bounds.minY then
		return
	end

	if y > bounds.maxY then
		return
	end

	if z < bounds.minZ then
		return
	end

	if z > bounds.maxZ then
		return
	end

	return true
end

function GameUtil.normalize(x, y, z)
	local dx = x * x
	local dy = y * y
	local dz = z * z
	local dist = dx + dy + dz

	if dist == 0 then
		dist = 0.0001
	end

	dist = math.sqrt(dist)

	return x / dist, y / dist, z / dist
end

function GameUtil.distance(x, y, z, x1, y1, z1)
	local dx = x - x1
	local dy = y - y1
	local dz = z - z1

	dx = dx * dx
	dy = dy * dy
	dz = dz * dz

	local dist = dx + dy + dz

	return math.sqrt(dist)
end

function GameUtil.point_between_lines(targetX, targetY, fromX, fromY, toX, toY)
	local slope_AB = toX - fromX ~= 0 and (toY - fromY) / (toX - fromX) or nil
	local slope_normal = slope_AB and -1 / slope_AB or 0
	local intercept_L1 = fromY - slope_normal * fromX
	local intercept_L2 = toY - slope_normal * toX
	local y_on_L1 = slope_normal * targetX + intercept_L1
	local y_on_L2 = slope_normal * targetX + intercept_L2

	return y_on_L1 <= targetY and targetY <= y_on_L2 or targetY <= y_on_L1 and y_on_L2 <= targetY
end

function GameUtil.distance_point_to_line(targetX, targetY, fromX, fromY, toX, toY)
	local A, B, C

	if toX ~= fromX then
		A = (toY - fromY) / (toX - fromX)
		B = -1
		C = fromY - (toY - fromY) / (toX - fromX) * fromX
	else
		A = 1
		B = 0
		C = -fromX
	end

	return math.abs(A * targetX + B * targetY + C) / math.sqrt(A^2 + B^2)
end

function GameUtil.isLineSegmentIntersectingCircle(p1, p2, center, radius)
	local dx = p2.x - p1.x
	local dy = p2.y - p1.y
	local fx = p1.x - center.x
	local fy = p1.y - center.y
	local a = dx * dx + dy * dy
	local b = 2 * (fx * dx + fy * dy)
	local c = fx * fx + fy * fy - radius * radius
	local discriminant = b * b - 4 * a * c

	if discriminant < 0 then
		return false
	end

	local sqrtDiscriminant = math.sqrt(discriminant)
	local t1 = (-b - sqrtDiscriminant) / (2 * a)
	local t2 = (-b + sqrtDiscriminant) / (2 * a)

	return t1 >= 0 and t1 <= 1 or t2 >= 0 and t2 <= 1
end

function GameUtil.removeRichColor(str)
	return string.gsub(str, "</-color.->", "")
end

function GameUtil.SetActive(go, active)
	if go ~= nil and go.gameObject then
		goutil.setActive(go.gameObject, active)
	end
end

function GameUtil.GetActive(go)
	if go == nil or go.gameObject == nil or goutil.isNil(go.gameObject) then
		return false
	else
		return go.gameObject.activeSelf
	end
end

function GameUtil.asBtn(go)
	local btn = go.gameObject:GetComponent(goutil.Type_UIButton)

	if btn then
		return Framework.ButtonAdapter.Get(go.gameObject)
	else
		return Framework.UIClickTrigger.Get(go.gameObject)
	end
end

function GameUtil.addClickHandler(go, handler, handlerObj)
	if goutil.isNil(go) then
		return
	end

	local btn = GameUtil.asBtn(go)

	btn:RemoveClickListener()

	if handlerObj then
		btn:AddClickListener(handler, handlerObj)
	else
		btn:AddClickListener(handler)
	end
end

function GameUtil.rmClickHandler(go)
	if goutil.isNil(go) then
		return
	end

	GameUtil.asBtn(go):RemoveClickListener()
end

function GameUtil.whenLocalDataInited(callBack)
	LocalUserDataController.instance:whenLocalDataInited(callBack)
end

function GameUtil.handler(method, ...)
	if method == nil or type(method) ~= "function" then
		if enableDebug then
			printError("注意：GameUtil.handler传入了空方法")
		end

		return GameUtil.EmptyFunction()
	end

	local a, b, c, d, e, f, g, h, i, j = ...
	local len = select("#", ...)

	return function(...)
		if len == 0 then
			return method(...)
		elseif len == 1 then
			return method(a, ...)
		elseif len == 2 then
			return method(a, b, ...)
		elseif len == 3 then
			return method(a, b, c, ...)
		elseif len == 4 then
			return method(a, b, c, d, ...)
		elseif len == 5 then
			return method(a, b, c, d, e, ...)
		elseif len == 6 then
			return method(a, b, c, d, e, f, ...)
		elseif len == 7 then
			return method(a, b, c, d, e, f, g, ...)
		elseif len == 8 then
			return method(a, b, c, d, e, f, g, j, ...)
		elseif len == 9 then
			return method(a, b, c, d, e, f, g, j, h, ...)
		elseif len == 10 then
			return method(a, b, c, d, e, f, g, j, h, i, ...)
		elseif enableDebug then
			printError("error: 超过10个参数")
		end
	end
end

function GameUtil.EmptyFunction()
	return
end

function GameUtil.callBack(func, ...)
	if func ~= nil and type(func) == "function" then
		local args = {
			...
		}

		return func(GameUtil.unpack10(args))
	end

	return nil
end

function GameUtil.unpack10(tb)
	if tb then
		return tb[1], tb[2], tb[3], tb[4], tb[5], tb[6], tb[7], tb[8], tb[9], tb[10]
	end

	return nil
end

function GameUtil.AddLuaOnce(go, luaCls)
	local theCls = GameUtil.GetLua(go, luaCls)

	if not theCls then
		local LuaComponentContainer = Framework.LuaComponentContainer

		theCls = LuaComponentContainer.Add(go.gameObject, luaCls)
	end

	return theCls
end

function GameUtil.GetLua(go, luaCls)
	local LuaComponentContainer = Framework.LuaComponentContainer

	return (LuaComponentContainer.Get(go.gameObject, luaCls))
end

function GameUtil.RemoveLua(go, luaCls)
	if luaCls then
		local LuaComponentContainer = Framework.LuaComponentContainer

		LuaComponentContainer.Remove(go.gameObject, luaCls)
	end
end

function GameUtil.getUserDayData(key, callBack)
	return LocalUserDataController.instance:getUserDayData(key, callBack)
end

function GameUtil.saveUserDayData(key, value)
	return LocalUserDataController.instance:saveUserDayData(key, value)
end

function GameUtil.getUserWeekData(key, callBack)
	return LocalUserDataController.instance:getUserWeekData(key, callBack)
end

function GameUtil.saveUserWeekData(key, value)
	return LocalUserDataController.instance:saveUserWeekData(key, value)
end

function GameUtil.getUserData(key, callBack)
	return LocalUserDataController.instance:getUserData(key, callBack)
end

function GameUtil.saveUserData(key, value)
	return LocalUserDataController.instance:saveUserData(key, value)
end

function GameUtil.doCallbackWhenFirst(key, firstTimeCallback, nextTimeCallBack)
	LocalUserDataController.instance:doCallbackWhenFirst(key, firstTimeCallback, nextTimeCallBack)
end

function GameUtil.clickEnabled(boo, key)
	GameUtil.CLICK_ENABLED_KEY_LIST = GameUtil.CLICK_ENABLED_KEY_LIST or {}

	local num = GameUtil.CLICK_ENABLED_KEY_LIST[key]

	if boo then
		GameUtil.CLICK_ENABLED_KEY_LIST[key] = nil
	else
		num = checknumber(num) + 1
		GameUtil.CLICK_ENABLED_KEY_LIST[key] = num
	end

	local len = table.nums(GameUtil.CLICK_ENABLED_KEY_LIST)

	GlobalModel.instance:setUIBlocking(len > 0)

	local scene = SceneMgr.instance:getCurScene()

	if scene and scene.picker then
		scene.picker:enabled(len == 0)
	end
end

function GameUtil.resetClickEnabled()
	GameUtil.CLICK_ENABLED_KEY_LIST = nil

	GlobalModel.instance.eventSystem:SetActive(false)
	GlobalModel.instance.eventSystem:SetActive(true)

	local scene = SceneMgr.instance:getCurScene()

	if scene and scene.picker then
		scene.picker:enabled(true)
	end
end

function GameUtil.setImgJianying(go, isJianying, r, g, b)
	local material
	local image = go:GetComponent(goutil.Type_UIImage) or go:GetComponent(ComponentType.RawImage)
	local mat = image.material

	if isJianying then
		if mat and mat.name == "jianying_tmp" then
			material = mat

			if r ~= nil and g ~= nil and b ~= nil then
				GoUtil.SetMatColor(mat, "_FillColor", r / 255, g / 255, b / 255, 1)
			end
		else
			material = CommonPreloader.instance:getSkinlibAsset(CommonResPath.JianYingMat)

			if material ~= nil and r ~= nil and g ~= nil and b ~= nil then
				material = goutil.clone(material, "jianying_tmp")

				GoUtil.SetMatColor(material, "_FillColor", r / 255, g / 255, b / 255, 1)
			end

			image.material = material
		end
	else
		if mat and mat.name == "jianying_tmp" then
			goutil.destroy(mat)
		end

		image.material = nil
	end

	if r ~= nil and g ~= nil and b ~= nil then
		return material
	end
end

function GameUtil.SetGray(go, isGray)
	if go and go.gameObject then
		uGuiUtil.setGoGrayState(go.gameObject, isGray)
	end
end

function GameUtil.setBtnState(go, txt, isGray)
	if isGray then
		txt.color = Color.New(1, 1, 1, 1)

		uGuiUtil.setImageGrayStateRecursive(go, true)
	else
		txt.color = Color.New(1, 1, 1, 1)

		uGuiUtil.setImageGrayStateRecursive(go, false)
	end
end

local json = require("cjson")

function GameUtil.jsonToString(obj)
	return (obj ~= nil or nil) and json.encode(obj)
end

function GameUtil.jsonToTable(jsonStr)
	local obj

	return (not string.nilorempty(jsonStr) and json or nil) and json.decode(jsonStr)
end

local romanNumber = {
	"I",
	"II",
	"III",
	"IV",
	"V",
	"VI",
	"VII",
	"VIII",
	"IX",
	"X"
}

function GameUtil.toRomanNumber(num)
	local number = num % 10
	local tens = math.floor(num / 10)
	local roman = ""

	if number ~= 0 then
		roman = romanNumber[number]
	end

	for i = 1, tens do
		roman = "X" .. roman
	end

	return roman
end

function GameUtil.setProgress(progressUI, curValue, valueStepArr, progStepArr)
	if #progStepArr ~= #valueStepArr then
		error(" GameUtil.setProgress step is not euqip ")
	end

	curValue = checknumber(curValue)

	local result = 0

	for i = 1, #valueStepArr do
		if curValue >= valueStepArr[i] then
			if i == #valueStepArr then
				if progressUI then
					progressUI:SetValue(progStepArr[i])
				end

				result = progStepArr[i]
			else
				local startStep, endStep, beginValue, endValue = valueStepArr[i], valueStepArr[i + 1], progStepArr[i], progStepArr[i + 1]
				local v = beginValue + (endValue - beginValue) * math.min(1, (curValue - startStep) / (endStep - startStep))

				if progressUI then
					progressUI:SetValue(v)
				end

				result = v
			end
		end
	end

	return result
end

function GameUtil.getTimeHHMMSS(timer)
	local _time = checknumber(timer)
	local hour = math.floor(_time / 3600)
	local min = math.floor(_time % 3600 / 60)
	local sec = _time % 60

	return hour, min, sec
end

function GameUtil.getTimeDDHHMMSS(timer)
	local _time = checknumber(timer)
	local day = math.floor(_time / 86400)
	local hour = math.floor(_time % 86400 / 3600)
	local min = math.floor(_time % 3600 / 60)
	local sec = _time % 60

	return day, hour, min, sec
end

function GameUtil.formatTimeStamp(fmt, timeStamp)
	timeStamp = checknumber(timeStamp) + ServerTime._clientToServerOffset

	return os.date(fmt, timeStamp)
end

function GameUtil.formatTimeString(fmt, timeString)
	local timeStamp = GameUtil.string2time(timeString)

	return GameUtil.formatTimeStamp(fmt, timeStamp)
end

function GameUtil.string2time(timeString)
	local timeTable = GameUtil.parseToTimeTable(timeString)
	local timeStamp = os.time(timeTable)

	timeStamp = timeStamp - ServerTime._clientToServerOffset

	return timeStamp
end

function GameUtil.string2date(timeString)
	local timeStamp = GameUtil.string2time(timeString)

	return GameUtil.time2date(timeStamp)
end

function GameUtil.time2date(timeStamp)
	timeStamp = checknumber(timeStamp) + ServerTime._clientToServerOffset

	return os.date("*t", timeStamp)
end

function GameUtil.date2time(year, month, day, hour, min, sec)
	year = checknumber(year)
	month = checknumber(month)
	day = checknumber(day)
	hour = checknumber(hour)
	min = checknumber(min)
	sec = checknumber(sec)

	if year == 0 then
		year = ServerTime.nowDateServerLook().year
	end

	if day == 0 then
		day = ServerTime.nowDateServerLook().day
	end

	if month == 0 then
		month = ServerTime.nowDateServerLook().month
	end

	local timeStamp = os.time({
		year = year,
		month = month,
		day = day,
		hour = hour,
		min = min,
		sec = sec
	})

	timeStamp = timeStamp - ServerTime._clientToServerOffset

	return timeStamp
end

GameUtil._time_map = {}

function GameUtil.resetTimeMap()
	GameUtil._time_map = {}
end

function GameUtil.parseToTimeTable(timeString)
	if type(timeString) ~= "string" then
		printError("type(timeString)  注意 nil")

		return {
			hour = 0,
			min = 0,
			sec = 0,
			isdst = false,
			year = ServerTime.nowDateServerLook().year,
			month = ServerTime.nowDateServerLook().month,
			day = ServerTime.nowDateServerLook().day
		}
	end

	local obj = GameUtil._time_map[timeString]

	if obj == nil then
		local fun = string.gmatch(timeString, "%d+")
		local y = fun() or 0

		if checknumber(y) == 0 then
			y = ServerTime.nowDateServerLook().year
		end

		local m = fun() or 0

		if checknumber(m) == 0 then
			m = ServerTime.nowDateServerLook().month
		end

		local d = fun() or 0

		if checknumber(d) == 0 then
			d = ServerTime.nowDateServerLook().day
		end

		local H = fun() or 0

		H = checknumber(H)

		local M = fun() or 0

		M = checknumber(M)

		local S = fun() or 0

		S = checknumber(S)
		obj = {
			isdst = false,
			year = y,
			month = m,
			day = d,
			hour = H,
			min = M,
			sec = S
		}
		GameUtil._time_map[timeString] = obj
	end

	return obj
end

GameUtil.errorTimePeriod = -1
GameUtil.beforeTimePeriod = 1
GameUtil.inTimePeriod = 2
GameUtil.afterTimePeriod = 3

function GameUtil.checkIsInTimePeriod(timeLimitStart, timeLimitEnd, isIgnoreDay)
	return GameUtil.getTimePeriodType(timeLimitStart, timeLimitEnd, isIgnoreDay) == GameUtil.inTimePeriod
end

function GameUtil.getTimePeriodType(timeLimitStart, timeLimitEnd, isIgnoreDay)
	if string.nilorempty(timeLimitStart) or string.nilorempty(timeLimitEnd) then
		print("GameUtil.checkIsInTimePeriod 参数 timeLimitStart , timeLimitEnd 不完全")

		return GameUtil.errorTimePeriod
	end

	if isIgnoreDay == true then
		timeLimitStart = "0-0-0 " .. timeLimitStart
		timeLimitEnd = "0-0-0 " .. timeLimitEnd
	end

	local timeStart = GameUtil.string2time(timeLimitStart)
	local timeEnd = GameUtil.string2time(timeLimitEnd)

	return GameUtil.getTimePeriodTypeBySec(timeStart, timeEnd)
end

function GameUtil.getTimePeriod(startTime, endTime)
	local var_138_9000
	local timePeriod = GameUtil.errorTimePeriod

	startTime, endTime = startTime or "", endTime or ""

	if string.nilorempty(var_138_9000) and string.nilorempty(endTime) then
		timePeriod = GameUtil.inTimePeriod
	elseif not string.nilorempty(startTime) and not string.nilorempty(endTime) then
		timePeriod = GameUtil.getTimePeriodType(startTime, endTime)
	elseif string.nilorempty(startTime) and not string.nilorempty(endTime) then
		local timeNow = ServerTime.now()
		local timeEnd = GameUtil.string2time(endTime)

		timePeriod = timeEnd <= timeNow and GameUtil.afterTimePeriod or GameUtil.getTimePeriodTypeBySec(timeNow, timeEnd)
	elseif not string.nilorempty(startTime) and string.nilorempty(endTime) then
		local timeStart = GameUtil.string2time(startTime)
		local timeNow = ServerTime.now()

		timePeriod = timeNow < timeStart and GameUtil.beforeTimePeriod or GameUtil.getTimePeriodTypeBySec(timeStart, timeNow + 1)
	end

	return timePeriod
end

function GameUtil.getTimePeriodTypeBySec(timeStart, timeEnd)
	return GameUtil.getTimePeriodBySecWithOther(ServerTime.now(), timeStart, timeEnd)
end

function GameUtil.getTimePeriodBySecWithOther(otherTime, timeStart, timeEnd)
	if timeEnd < timeStart then
		if timeStart <= otherTime then
			timeEnd = timeEnd + 86400
		elseif otherTime <= timeEnd then
			timeStart = timeStart - 86400
		end
	end

	local timePeriod = GameUtil.errorTimePeriod

	if timeStart <= otherTime and otherTime < timeEnd then
		timePeriod = GameUtil.inTimePeriod
	elseif otherTime < timeStart then
		timePeriod = GameUtil.beforeTimePeriod
	elseif timeEnd <= otherTime then
		timePeriod = GameUtil.afterTimePeriod
	end

	return timePeriod
end

GameUtil.SERVER_TICK_DAILYR_EFRESH = 5

function GameUtil.getTimestampOnStartAndEnd(referenceTimestamp, fromDay, duration)
	local time = GameUtil.time2date(referenceTimestamp)
	local day = time.day

	if time.hour < GameUtil.SERVER_TICK_DAILYR_EFRESH then
		day = day - 1
	end

	local startDay = day + fromDay - 1
	local endDay = startDay + duration
	local startTime = os.time({
		sec = 0,
		min = 0,
		year = time.year,
		month = time.month,
		day = startDay,
		hour = GameUtil.SERVER_TICK_DAILYR_EFRESH
	})
	local endTime = os.time({
		sec = 0,
		min = 0,
		year = time.year,
		month = time.month,
		day = endDay,
		hour = GameUtil.SERVER_TICK_DAILYR_EFRESH
	})

	startTime = startTime - ServerTime._clientToServerOffset
	endTime = endTime - ServerTime._clientToServerOffset

	return startTime, endTime
end

function GameUtil.getDaysByTimestamp(originTime, finalTime)
	local regTime = originTime
	local regDate = GameUtil.time2date(regTime)

	if regDate.hour < GameUtil.SERVER_TICK_DAILYR_EFRESH then
		regDate.day = regDate.day - 1
	end

	regDate.hour = GameUtil.SERVER_TICK_DAILYR_EFRESH
	regDate.min = 0
	regDate.sec = 0

	local curDate = GameUtil.time2date(finalTime)

	if curDate.hour < GameUtil.SERVER_TICK_DAILYR_EFRESH then
		curDate.day = curDate.day - 1
	end

	curDate.hour = GameUtil.SERVER_TICK_DAILYR_EFRESH
	curDate.min = 0
	curDate.sec = 0

	local startTime = os.time(regDate)
	local endTime = os.time(curDate)
	local subSec = os.difftime(endTime, startTime)

	return math.round(subSec / 86400) + 1
end

function GameUtil.getNextWeekDay(day)
	local nowTime = ServerTime.now() - GameUtil.SERVER_TICK_DAILYR_EFRESH * 3600
	local timetable = GameUtil.time2date(nowTime)
	local wd = timetable.wday - 1
	local passDay = day - wd

	if passDay <= 0 then
		passDay = passDay + 7
	end

	timetable.day = timetable.day + passDay
	timetable.hour = GameUtil.SERVER_TICK_DAILYR_EFRESH
	timetable.min = 0
	timetable.sec = 0

	return GameUtil.date2time(timetable.year, timetable.month, timetable.day, timetable.hour, timetable.min, timetable.sec)
end

function GameUtil.checkIsOnWeekDay(day)
	local nowTime = ServerTime.now() - GameUtil.SERVER_TICK_DAILYR_EFRESH * 3600
	local timetable = GameUtil.time2date(nowTime)
	local wd = timetable.wday - 1

	return wd == day % 7
end

function GameUtil.getStartAndEndInWeek(nowTime)
	local todayTime = nowTime - GameUtil.SERVER_TICK_DAILYR_EFRESH * 3600
	local timetable = GameUtil.time2date(todayTime)
	local wd = timetable.wday - 1
	local startDay = (wd + 7 - 5) % 7
	local endDay = (5 - wd + 7) % 7

	if startDay == 0 and endDay == 0 then
		endDay = 7
	end

	local leftStamp = Mathf.Max(todayTime - startDay * 86400, 0)
	local rightStamp = todayTime + endDay * 86400
	local ld = GameUtil.time2date(leftStamp)
	local rd = GameUtil.time2date(rightStamp)
	local leftTime = GameUtil.date2time(ld.year, ld.month, ld.day, GameUtil.SERVER_TICK_DAILYR_EFRESH, 0, 0)
	local rightTime = GameUtil.date2time(rd.year, rd.month, rd.day, GameUtil.SERVER_TICK_DAILYR_EFRESH, 0, 0)

	return leftTime, rightTime
end

function GameUtil.getStartDayAndEndDay(fromDay, duration)
	local startDay = fromDay
	local endDay = duration - 1 + fromDay

	return startDay, endDay
end

function GameUtil.getOpenDayPeriodType(fromDay, duration)
	fromDay = checknumber(fromDay)
	duration = checknumber(duration)

	local startDay, endDay = GameUtil.getStartDayAndEndDay(fromDay, duration)
	local openDays = GameUtil.getOpenAreaDaysForFive()

	if openDays < startDay then
		return GameUtil.beforeTimePeriod
	elseif startDay <= openDays and openDays <= endDay then
		return GameUtil.inTimePeriod
	else
		return GameUtil.afterTimePeriod
	end
end

function GameUtil.getCreateRoleDayPeriodType(fromDay, duration)
	fromDay = checknumber(fromDay)
	duration = checknumber(duration)

	local startDay, endDay = GameUtil.getStartDayAndEndDay(fromDay, duration)
	local createDays = GameUtil.getCreatingRolesDaysForFive()

	if createDays < startDay then
		return GameUtil.beforeTimePeriod
	elseif startDay <= createDays and createDays <= endDay then
		return GameUtil.inTimePeriod
	else
		return GameUtil.afterTimePeriod
	end
end

function GameUtil.isInOpenDaysByOpenDay(fromDay, duration)
	return GameUtil.getOpenDayPeriodType(fromDay, duration) == GameUtil.inTimePeriod
end

function GameUtil.isBeforeEndDaysByOpenDay(fromDay, duration)
	local state = GameUtil.getOpenDayPeriodType(fromDay, duration)

	return state ~= GameUtil.afterTimePeriod
end

function GameUtil.isInOpenDaysByCreateRole(fromDay, duration)
	return GameUtil.getCreateRoleDayPeriodType(fromDay, duration) == GameUtil.inTimePeriod
end

function GameUtil.getCreatingRolesDaysForFive()
	if RoleModel == nil or RoleModel.instance == nil then
		return 1
	end

	local regTime = RoleModel.instance:getActiveTimeSec()

	return GameUtil.getDaysByTimestamp(regTime, ServerTime.now())
end

function GameUtil.getOpenAreaDaysForFive()
	if RoleModel == nil or RoleModel.instance == nil then
		return 1
	end

	local openTime = RoleModel.instance:getAreaOpenTimeSec()

	return GameUtil.getDaysByTimestamp(openTime, ServerTime.now())
end

function GameUtil.FormatTimeWords(timer, isNotHour)
	local hour, min, sec = GameUtil.getTimeHHMMSS(timer)

	if isNotHour then
		return string.format("%02d分%02d秒", min, sec)
	elseif hour >= 24 then
		return string.format("%s天%02d时%02d分%02d秒", math.floor(hour / 24), hour % 24, min, sec)
	else
		return string.format("%02d时%02d分%02d秒", hour, min, sec)
	end
end

function GameUtil.FormatTimeWordsNoSec(timer, isNotHour, isNotMin)
	local hour, min = GameUtil.getTimeHHMMSS(timer)

	if isNotHour then
		return string.format("%02d分", min)
	elseif hour >= 24 then
		if isNotMin then
			return string.format("%s天%02d时", math.floor(hour / 24), hour % 24)
		else
			return string.format("%s天%02d时%02d分", math.floor(hour / 24), hour % 24, min)
		end
	else
		return string.format("%02d时%02d分", hour, min)
	end
end

function GameUtil.FormatTimeSymbol(timer, onlyShowDay)
	local hour, min, sec = GameUtil.getTimeHHMMSS(timer)

	if hour >= 24 then
		if onlyShowDay then
			return string.format("%s天", math.floor(hour / 24))
		else
			return string.format("%s天 %02d:%02d:%02d", math.floor(hour / 24), hour % 24, min, sec)
		end
	elseif hour > 0 then
		return string.format("%02d:%02d:%02d", hour, min, sec)
	else
		return string.format("%02d:%02d", min, sec)
	end
end

function GameUtil.getFormatTimeByStamp(startStamp, endStamp)
	local fTimeStr = ""
	local sStamp, eStamp = checknumber(startStamp), checknumber(endStamp)

	if sStamp > 0 or eStamp > 0 then
		local var_157_0 = sStamp > 0 and GameUtil.time2date(startStamp) or nil
	end

	return fTimeStr
end

function GameUtil.getFormatTimeByDate(startDate, endDate)
	local fTimeStr = ""

	if startDate and endDate then
		fTimeStr = string.format("%02d.%02d %02d:%02d - %02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
	else
		local date = startDate or endDate

		fTimeStr = string.format("%02d.%02d %02d:%02d", date.month, date.day, date.hour, date.min)
	end

	return fTimeStr
end

function GameUtil.GetMonthMaxDay(year, month)
	local curDate = {}
	local curTime = os.date("*t", ServerTime.now())

	curDate.year = year and year or curTime.year
	curDate.month = (month and month or curTime.month) + 1

	if curDate.month > 12 then
		curDate.month = 1
	end

	curDate.day = 0

	return (os.date("%d", os.time(curDate)))
end

function GameUtil.GetGameResetTimeStamp()
	local dTime = ServerTime.nowDateServerLook()
	local currHour = dTime.hour

	dTime.hour = ClockMgr.instance._refreshTime
	dTime.min = 0
	dTime.sec = 0

	if currHour >= dTime.hour then
		dTime.day = dTime.day + 1
	end

	return GameUtil.date2time(dTime.year, dTime.month, dTime.day, dTime.hour, dTime.min, dTime.sec)
end

function GameUtil.SetSceneAmbient(sceneId)
	local sceneCo = SceneConfig.instance:getSceneCo(sceneId)

	if sceneCo and sceneCo.ambientColor then
		local ambient = sceneCo.ambientColor

		CSGameUtil.SetAmbientLightColor(ambient[1], ambient[2], ambient[3])
	else
		CSGameUtil.SetAmbientLightColor(255, 255, 255)
	end
end

function GameUtil.SetSceneAmbientColor(r, g, b)
	CSGameUtil.SetAmbientLightColor(r, g, b)
end

function GameUtil.getRotationYByDir(dirX, dirY)
	local defalty = 90
	local y

	if dirY ~= 0 and dirX ~= 0 then
		y = math.atan2(dirY, -dirX) * 180 / math.pi
		y = y > 0 and y - defalty or 360 + y - defalty
	elseif dirY == 0 and dirX ~= 0 then
		y = dirX / math.abs(dirX) > 0 and 180 - defalty or 0 - defalty
	elseif dirY ~= 0 and dirX == 0 then
		y = dirY / math.abs(dirY) > 0 and 90 - defalty or 270 - defalty
	end

	return y
end

function GameUtil.pbToTable(pbMsg, tb)
	if pbMsg == nil or type(pbMsg) ~= "table" then
		return nil
	end

	if pbMsg._fields ~= nil and _G.next(pbMsg._fields) ~= nil then
		for k, v in pairs(pbMsg._fields) do
			local val

			if v then
				val = type(v) ~= "table" and v or GameUtil.pbToTable(v)
			end

			tb = tb or {}
			tb[k.name] = val
		end

		return tb
	else
		for k, v in ipairs(pbMsg) do
			local val

			if v then
				val = type(v) ~= "table" and v or GameUtil.pbToTable(v)
			end

			tb = tb or {}
			tb[k] = val
		end

		return tb
	end
end

function GameUtil.expandRectTransform(transform)
	transform.anchorMin = Vector2.New(0, 0)
	transform.anchorMax = Vector2.New(1, 1)
	transform.offsetMin = Vector2.New(0, 0)
	transform.offsetMax = Vector2.New(0, 0)
end

function GameUtil.expScript(str, callback)
	GameUtil.expScriptPool = GameUtil.expScriptPool or {}

	local scrTree = GameUtil.expScriptPool[str]

	if scrTree == nil then
		scrTree = GameUtil.makeScriptTree(str, 0, 0)
		GameUtil.expScriptPool[str] = scrTree
	end

	return GameUtil.checkTree(scrTree, callback)
end

function GameUtil.checkTree(tt, callback)
	if tt.op == "|" then
		local tb = tt.tb
		local last = false

		for i = 1, #tb do
			last = last or GameUtil.checkTree(tb[i], callback)

			if last then
				return last
			end
		end

		return last
	elseif tt.op == "&" then
		local tb = tt.tb
		local last = true

		for i = 1, #tb do
			last = last and GameUtil.checkTree(tb[i], callback)

			if last == false then
				return last
			end
		end

		return last
	elseif tt.op == "!" then
		local tb = tt.tb
		local last = true

		for i = 1, #tb do
			last = last and not GameUtil.checkTree(tb[i], callback)
		end

		return last
	else
		return callback(tt.op)
	end
end

function GameUtil.makeScriptTree(str, idx, step)
	local lastNode
	local last = ""
	local len = #str

	while idx < len do
		idx = idx + 1

		local c = string.sub(str, idx, idx)

		if c == "(" then
			local node, nIdx = GameUtil.makeScriptTree(str, idx, step + 1)

			if lastNode then
				table.insert(lastNode.tb, node)
			else
				lastNode = node
			end

			idx = nIdx

			if step == -1 then
				return node, idx
			end

			if idx == len then
				return lastNode
			end

			c = string.sub(str, idx, idx)
		elseif c == ")" then
			if last ~= "" then
				local node = {
					op = last
				}

				if lastNode and (lastNode.op == "&" or lastNode.op == "|") then
					table.insert(lastNode.tb, node)
				else
					lastNode = node
				end

				last = ""
			end

			step = step - 1

			return lastNode, idx + 1
		end

		if c == "&" then
			if last ~= "" then
				local node = {
					op = last
				}

				if step == -1 then
					return node, idx - 1
				end

				if lastNode and (lastNode.op == "&" or lastNode.op == "|") then
					table.insert(lastNode.tb, node)
				else
					lastNode = node
				end

				last = ""
			end

			if lastNode and lastNode.op ~= c then
				local node = {
					op = c,
					tb = {}
				}

				table.insert(node.tb, lastNode)

				lastNode = node
			end
		elseif c == "|" then
			if last ~= "" then
				local node = {
					op = last
				}

				if step == -1 then
					return node, idx - 1
				end

				if lastNode and (lastNode.op == "&" or lastNode.op == "|") then
					table.insert(lastNode.tb, node)
				else
					lastNode = node
				end

				last = ""
			end

			if lastNode and lastNode.op ~= c then
				local node = {
					op = c,
					tb = {}
				}

				table.insert(node.tb, lastNode)

				lastNode = node
			end
		elseif c == "!" then
			local node = {
				op = c,
				tb = {}
			}
			local tem, nIdx = GameUtil.makeScriptTree(str, idx, -1)

			table.insert(node.tb, tem)

			if lastNode then
				table.insert(lastNode.tb, node)
			else
				lastNode = node
			end

			idx = nIdx
		else
			last = last .. c

			if idx == len and last ~= "" then
				local node = {
					op = last
				}

				if step == -1 then
					return node, idx
				end

				if lastNode and (lastNode.op == "&" or lastNode.op == "|") then
					table.insert(lastNode.tb, node)
				else
					lastNode = node
				end

				last = ""
			end
		end
	end

	return lastNode
end

function GameUtil.run_script(script, env)
	local env = env or {}
	local func

	if _G.setfenv then
		func = loadstring(script)

		if func then
			setfenv(func, env)
		end
	else
		func = load(script, nil, nil, env)
	end

	if func == nil then
		error("Invalid syntax.")
	end

	return func()
end

function GameUtil.getPropertyInfo(id, value, color)
	id = checknumber(id)
	value = checknumber(value)

	local value_color = color or "#ffffff"
	local name = GameUtil.GetProperties(id)
	local value, symbol = GameUtil.GetPropertyValue(id, value)
	local str = string.format("%s %s<color=%s>%s</color>", name, symbol, value_color, value)

	return name, value, symbol, str
end

function GameUtil.GetProperties(id)
	return ConstString.Attr[id]
end

function GameUtil.GetPropertyValue(id, value)
	id = checknumber(id)

	local cfg = GameEnum.ItemAttrNormal[id]

	if cfg == nil then
		cfg = {
			kind = 1,
			name = "",
			symbol = 1
		}
	end

	local mark = cfg.kind == 2 and "%" or ""

	if cfg.kind == 2 then
		value = checknumber(value) * 100
	elseif cfg.kind == 1 then
		value = math.floor(checknumber(value) + 0.5)
	end

	local sym = cfg.symbol == 1 and "+" or "-"

	value = value - value % 0.01

	return value .. mark, sym
end

function GameUtil.PrintFunctionCallPos(function_name, stack_layer)
	local create_info = debug.getinfo(stack_layer or 3, "Sl")
	local print_msg = ""

	if create_info then
		function_name = function_name or ""
		print_msg = string.format("%s calledPos = %s[%d]", function_name, create_info.source, create_info.currentline)

		printInfo(print_msg)
	end

	return print_msg
end

function GameUtil.HtmlColorTxt(content, color)
	local ncolor = color or "#ffffff"

	return "<color='" .. ncolor .. "'>" .. content .. "</color>"
end

function GameUtil.parseMatStr2Table(str)
	local t = string.split(str, ":")

	for i = 1, #t do
		t[i] = checknumber(t[i])
	end

	return t
end

function GameUtil.GetGoodsColor(quality)
	return GameUtil.goods_color_list[quality] or GameUtil.goods_color_list[0]
end

function GameUtil.getChildren(parent)
	local children = {}

	if not goutil.isNil(parent) then
		parent = parent.transform

		local childCount = parent.childCount

		for i = 1, childCount do
			local trans = parent:GetChild(i - 1)

			table.insert(children, trans.gameObject)
		end
	end

	return children
end

function GameUtil.updateCells(parent, datas, updateHandler, updateTarget, hideCells)
	local childlist = GameUtil.getChildren(parent)

	for _, v in ipairs(childlist) do
		if hideCells then
			v:SetActive(false)
		end
	end

	for k, v in ipairs(datas) do
		local cell = childlist[k]

		if not goutil.isNil(cell) then
			cell:SetActive(true)

			if updateHandler then
				if updateTarget then
					updateHandler(updateTarget, cell, v)
				else
					updateHandler(cell, v)
				end
			end
		end
	end
end

function GameUtil.updateCellsWithCreate(parent, datas, updateHandler, updateTarget, validChildIdx)
	local childlist = GameUtil.getChildren(parent)
	local i = 0

	while i < checknumber(validChildIdx) do
		table.remove(childlist, 1)

		i = i + 1
	end

	for _, v in ipairs(childlist) do
		v:SetActive(false)
	end

	local cloneGo = childlist[1]

	table.remove(childlist, 1)

	local cells = {}

	for k, v in ipairs(datas) do
		local cell = childlist[k]

		if cell == nil then
			cell = goutil.cloneAndSetParent(cloneGo, parent.transform)
		end

		cell:SetActive(true)

		if updateHandler then
			if updateTarget then
				updateHandler(updateTarget, cell, v)
			else
				updateHandler(cell, v)
			end
		end

		table.insert(cells, cell)
	end

	return cells
end

function GameUtil.updateCellsList(parent, cloneCellGo, datas, updateHandler, updateTarget)
	if goutil.isNil(parent) then
		printError(">>> GameUtil.updateCellsList parent is nil")

		return
	end

	GameUtil.SetActive(cloneCellGo, false)

	parent = parent.transform

	local childCount = parent.childCount

	if datas then
		if not #datas then
			local dataLen = 0
			local len = math.max(childCount, dataLen)
			local cells = {}

			for i = 1, len do
				local cell, trans

				if i <= childCount then
					trans = parent:GetChild(i - 1)
				end

				cell = trans == nil and goutil.cloneAndSetParent(cloneCellGo, parent.transform) or trans.gameObject

				if i <= dataLen then
					if datas then
						if not datas[i] then
							local data

							cell:SetActive(true)

							if updateHandler then
								if updateTarget then
									updateHandler(updateTarget, cell, data, i)
								else
									updateHandler(cell, data, i)
								end
							end
						end
					end
				else
					cell:SetActive(false)
				end

				table.insert(cells, cell)
			end

			return cells
		end
	end
end

function GameUtil.clearCells(parent, updateHandler, updateTarget, isClearChildren)
	if not goutil.isNil(parent) then
		parent = parent.transform

		local childCount = parent.childCount

		for i = 1, childCount do
			local trans = parent:GetChild(i - 1)
			local cell = trans.gameObject

			if updateHandler then
				if updateTarget then
					updateHandler(updateTarget, cell, i)
				else
					updateHandler(cell, i)
				end
			end
		end

		if isClearChildren then
			goutil.clearChildren(parent)
		end
	end
end

function GameUtil.updateCellsWithLen(parent, len, updateHandler, updateTarget)
	local t = {}

	for i = 1, len do
		table.insert(t, i)
	end

	GameUtil.updateCells(parent, t, updateHandler, updateTarget)
end

function GameUtil.getPosWihtRowAndCol(spaceX, spaceY, index, oriRow, oriCol, offsetX, offsetY)
	local row = oriRow or 0
	local col = oriCol or 0

	offsetX = offsetX or 0
	offsetY = offsetY or 0
	spaceX = spaceX or 0
	spaceY = spaceY or 0

	if row <= 0 and col <= 0 then
		printError("行列设置不正确", oriRow, oriCol)

		return 0, 0
	end

	if index < 0 then
		printError("index设置不正确", index)

		return 0, 0
	end

	if row > 0 and col <= 0 then
		return (index - 1) * spaceX + offsetX, offsetY
	elseif col > 0 and row <= 0 then
		return offsetX, (index - 1) * spaceY + offsetY
	else
		return (index - 1) % col * spaceX + offsetX, (math.ceil(index / col) - 1) * spaceY + offsetY
	end
end

function GameUtil.addSameAttrs(fromAttrs, toAttrs)
	toAttrs = toAttrs or {}

	if fromAttrs then
		for k, v in pairs(fromAttrs) do
			toAttrs[k] = checknumber(toAttrs[k]) + checknumber(v)
		end
	end

	return toAttrs
end

function GameUtil.getAstro(month, day)
	month = checknumber(month)
	day = checknumber(day)

	local index = month

	if day >= GameUtil.astroSplitDays[month] then
		index = index + 1
	end

	return GameUtil.astro[index]
end

function GameUtil.permuteArray(array)
	if array == nil or #array == 0 then
		return array
	end

	for i = #array, 2, -1 do
		local j = math.random(1, i)

		array[i] = array[j]
		array[j] = array[i]
	end

	return array
end

function GameUtil.getRandomMap(n, m)
	local array = {}

	for i = 1, n do
		array[i] = i
	end

	GameUtil.permuteArray(array)

	local map = {}

	for i = 1, m do
		map[array[i]] = true
	end

	return map
end

function GameUtil.toInteger(a)
	return a - a % 1
end

function GameUtil.getRandomEdge(edges)
	local maxWeight = 0

	for _, v in ipairs(edges) do
		local weight = v.y

		maxWeight = maxWeight + weight
	end

	local random = math.random(1, maxWeight)
	local totalWeight = 0

	for _, v in ipairs(edges) do
		totalWeight = totalWeight + v.y

		if random <= totalWeight then
			return v.x
		end
	end
end

function GameUtil.getVector2Distance(a, b)
	b = GameUtil.checkVector2(b)
	a = GameUtil.checkVector2(a)

	return Vector2.Distance(a, b)
end

function GameUtil.checkVector2(v)
	if v == nil then
		return Vector2.zero
	end

	if v.x == nil then
		v.x = 0
	end

	if v.y == nil then
		v.y = 0
	end

	return v
end

function GameUtil.clearSpineAnimsState(comps)
	for i = 0, comps.Length - 1 do
		comps[i]:ClearState()
	end
end

function GameUtil.getSpineAnimsComps(go)
	if goutil.isNil(go) then
		return
	end

	return (go:GetComponentsInChildren(skeletonAnimationType))
end

function GameUtil.playSpineAnimsWithGo(go, animState, flipX, loop, reStarted)
	if goutil.isNil(go) then
		return
	end

	local comps = go:GetComponentsInChildren(skeletonAnimationType)

	GameUtil.playSpineAnims(comps, animState, flipX, loop, reStarted)
end

function GameUtil.playSpineAnims(comps, animState, flipX, loop, reStarted)
	for i = 0, comps.Length - 1 do
		pcall(GoUtil.PlaySpineAnim, comps[i], animState, flipX, loop, reStarted, 1)
	end
end

function GameUtil.playSpineAnimsWithGoNoFlipX(go, animState, loop, reStarted)
	if goutil.isNil(go) then
		return
	end

	local comps = go:GetComponentsInChildren(skeletonAnimationType)

	GameUtil.playSpineAnimsNoFlipX(comps, animState, loop, reStarted)
end

function GameUtil.playSpineAnimsNoFlipX(comps, animState, loop, reStarted)
	for i = 0, comps.Length - 1 do
		pcall(GoUtil.PlaySpineAnim, comps[i], animState, loop, reStarted)
	end
end

function GameUtil.setSpineAnimsWithGo(go, animState, loop)
	if goutil.isNil(go) then
		return
	end

	local comps = go:GetComponentsInChildren(skeletonAnimationType)

	GameUtil.setSpineAnims(comps, animState, loop)
end

function GameUtil.setSpineAnims(comps, animState, loop)
	for i = 0, comps.Length - 1 do
		comps[i].loop = loop
		comps[i].AnimationName = animState
	end
end

function GameUtil.updateSpineLihuiEffOrder(spine)
	local effNode = goutil.findChild(spine, "effectsNode")

	if effNode then
		local canvas = UGUIToolHelper.FindCanvas(spine)

		if canvas then
			GoUtil.SetSortingOrder(effNode, canvas.sortingOrder)
		end
	end
end

function GameUtil.getClientEncryptedKey(clientKey, serverKey, serverResList)
	local encryptedKey = 0

	if serverKey and clientKey then
		local serverRandomKey = GenEncryptedKeyUtil.dxor(serverKey, clientKey)

		for k, num in ipairs(serverResList) do
			encryptedKey = num % 2 == 0 and encryptedKey + (num + serverRandomKey) * 5381 or encryptedKey + (num + clientKey) * 31
		end
	elseif enableDebug then
		printError(">>>>错误的参数，不能为nil 其中 serverKey:", serverKey, " clientKey:", clientKey)
	end

	return encryptedKey
end

function GameUtil.checkTimeStr(str, getStartTime)
	local startTime = 0

	if str == "全天" then
		if getStartTime then
			startTime = -1
		end

		return true, startTime
	else
		local arr = string.split(str, "|")
		local type = arr[1]
		local timeStr = arr[2]

		if type == "时段" then
			local tem = string.split(timeStr, ",")

			if getStartTime then
				startTime = GameUtil.string2time(tem[1])
			end

			return GameUtil.checkIsInTimePeriod(tem[1], tem[2]), startTime
		elseif type == "每周" then
			local nowTime = ServerTime.now()
			local timetable = GameUtil.time2date(nowTime)
			local tem = string.split(timeStr, "#")

			for k, v in pairs(tem) do
				local temArr = string.split(v, "@")
				local dayStr = temArr[1]
				local time = temArr[2]
				local days = string.split(dayStr, "-")
				local checkDays = {}

				if #days > 1 then
					local a = checknumber(days[1])
					local len = checknumber(days[2])

					for d = a, len do
						table.insert(checkDays, d)

						if d == 7 then
							table.insert(checkDays, 0)
						end
					end
				else
					local d = checknumber(days[1])

					table.insert(checkDays, d)

					if d == 7 then
						table.insert(checkDays, 0)
					end
				end

				local wd = timetable.wday - 1

				if table.indexof(checkDays, wd) ~= false then
					local timeArr = string.split(time, ",")

					for jj, vv in pairs(timeArr) do
						local pp = string.split(vv, "-")

						if GameUtil.checkIsInTimePeriod(pp[1], pp[2], true) then
							if getStartTime then
								startTime = GameUtil.string2time(pp[1])
							end

							return true, startTime
						end
					end
				end
			end
		elseif type == "每月" then
			local nowTime = ServerTime.now()
			local timetable = GameUtil.time2date(nowTime)
			local tem = string.split(timeStr, "#")

			for k, v in pairs(tem) do
				local temArr = string.split(v, "@")
				local dayStr = temArr[1]
				local time = temArr[2]
				local days = string.split(dayStr, "-")
				local checkDays = {}

				if #days > 1 then
					local a = checknumber(days[1])
					local len = checknumber(days[2])

					for d = a, len do
						table.insert(checkDays, d)
					end
				else
					local d = checknumber(days[1])

					table.insert(checkDays, d)
				end

				local wd = timetable.day

				if table.indexof(checkDays, wd) ~= false then
					local timeArr = string.split(time, ",")

					for jj, vv in pairs(timeArr) do
						local pp = string.split(vv, "-")

						if GameUtil.checkIsInTimePeriod(pp[1], pp[2], true) then
							if getStartTime then
								startTime = GameUtil.string2time(pp[1])
							end

							return true, startTime
						end
					end
				end
			end
		end
	end

	return false, startTime
end

function GameUtil.playSliderAnimation(scrollRect, onComplete)
	local startPos = 0
	local endPos = 1
	local duration = 3
	local delay = 1

	local function updateTween(num)
		if scrollRect then
			scrollRect.horizontalNormalizedPosition = num
		end
	end

	scrollRect.horizontalNormalizedPosition = 0

	local sequence = DG.Tweening.DOTween.Sequence()

	sequence:SetDelay(delay)

	local tweener1 = TweenUtil.DOTweenNum(startPos, endPos, duration, updateTween, {})
	local tweener2 = TweenUtil.DOTweenNum(endPos, startPos, duration - 1, updateTween, {})
	local tweener3 = TweenUtil.DoDelay(1, onComplete)

	sequence:Append(tweener1)
	sequence:Append(tweener2)
	sequence:Append(tweener3)

	return sequence
end

function GameUtil.getColorByHexColor(strColor, isNotClamp01)
	local newstr = string.gsub(strColor, "#", "")
	local colorlist = {}
	local index = 1

	while index < string.len(newstr) do
		local tempstr = string.sub(newstr, index, index + 1)

		table.insert(colorlist, tonumber(tempstr, 16))

		index = index + 2
	end

	local num = 255

	if isNotClamp01 then
		num = 1
	end

	local r, g, b, a = 1, 1, 1, 1

	if #colorlist >= 3 then
		r = colorlist[1] / num
		g = colorlist[2] / num
		b = colorlist[3] / num
	end

	return {
		r = r,
		g = g,
		b = b,
		a = (#colorlist == 4 or nil) and colorlist[4] / num
	}
end

function GameUtil.getTimeTxtByStr(startTime, endTime, showType)
	local startTimestamp = GameUtil.string2time(startTime)
	local endTimestamp = GameUtil.string2time(endTime)

	return GameUtil.getTimeTxt(startTimestamp, endTimestamp, showType)
end

function GameUtil.getTimeTxt(startTimestamp, endTimestamp, showType)
	local startDate = GameUtil.time2date(startTimestamp)
	local endDate = GameUtil.time2date(endTimestamp)

	if showType == GameEnum.TimeTxt.CN_M_D_H then
		return string.format("%d%s%d%s %d:%02d - %d%s%d%s %d:%02d", startDate.month, lang("mail_mon"), startDate.day, lang("mail_day"), startDate.hour, startDate.min, endDate.month, lang("mail_mon"), endDate.day, lang("mail_day"), endDate.hour, endDate.min)
	elseif showType == GameEnum.TimeTxt.M_D_H then
		return string.format("%02d.%02d %d:%02d - %02d.%02d %d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
	elseif showType == GameEnum.TimeTxt.Y_M_D_H then
		return string.format("%s.%02d.%02d %d:%02d - %s.%02d.%02d %d:%02d", startDate.year, startDate.month, startDate.day, startDate.hour, startDate.min, endDate.year, endDate.month, endDate.day, endDate.hour, endDate.min)
	else
		return "无效显示类型"
	end
end

function GameUtil.getActTimeDesc(activityType, activityId, timeFormat, showType)
	return ActivityDefineController.instance:getActTimeDesc(activityType, activityId, timeFormat, showType)
end

function GameUtil.getFakeRandomNumberArrayBySeed(seed, n, m)
	if not seed then
		print("没给种子呢，想白嫖？")

		return
	end

	local arr = {}

	for i = n, m do
		arr[#arr + 1] = i
	end

	math.randomseed(seed)

	for i = #arr, 2, -1 do
		local j = math.random(i)

		arr[i], arr[j] = arr[j], arr[i]
	end

	return arr
end

function GameUtil.getPosAndSizeDelta(uiGo)
	if not uiGo then
		return nil, nil
	end

	local pos = {
		0,
		0
	}
	local sizeDelta = {
		0,
		0
	}

	if uiGo and uiGo.gameObject then
		local rect = uiGo.gameObject:GetComponent("RectTransform")

		if rect ~= nil then
			sizeDelta = {
				rect.sizeDelta.x,
				rect.sizeDelta.y
			}
		end

		pos = uiGo.gameObject.transform.position

		local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

		pos = uiCamera:WorldToScreenPoint(pos)
	end

	return pos, sizeDelta
end

function GameUtil.resetUITransform(go)
	if not go or goutil.isNil(go) then
		return
	end

	Framework.TransformUtil.SetLocalPos(go.transform, 0, 0, 0)
	Framework.TransformUtil.SetLocalScale(go.transform, 1, 1, 1)
end

function GameUtil.getPetDefaultLevelAndAwakenLv(cfgStr)
	local level, awakenLv
	local arr = string.split(cfgStr, ":")
	local matType = checknumber(arr[1])

	if matType == MatType.Pet then
		level = checknumber(arr[3])

		local raceId = checknumber(arr[2])
		local petCo = CharacterConfig.instance:getPetCo(raceId)

		if petCo then
			awakenLv = petCo.initAwakenLv
		end
	end

	return level, awakenLv
end

function GameUtil.getTotalConfigs(configBaseName)
	local map = {
		[configBaseName] = true
	}

	for i = 1, math.huge do
		local name = string.format("%s_%s", configBaseName, i)
		local path = string.format("%s%s", ConfigMgr.instance._pathPrefix, name)
		local ok = pcall(require, path)

		if ok then
			map[name] = true
		else
			break
		end
	end

	return map
end

function GameUtil.isOpenHarmony()
	if Framework.OSDef.isEditor then
		return false
	end

	return Framework.OSDef.RunOS ~= Framework.OSDef.Android and Framework.OSDef.RunOS ~= Framework.OSDef.IOS
end

function GameUtil.combination(n, k)
	if k < 0 or n < k then
		return 0
	end

	if k == 0 or k == n then
		return 1
	end

	k = math.min(k, n - k)

	local res = 1

	for i = 1, k do
		res = res * (n - k + i) / i
	end

	return res
end

function GameUtil.precomputeCombination(n)
	local comb = {}

	for i = 0, n do
		comb[i] = GameUtil.combination(n, i)
	end

	return comb
end

function GameUtil.bezierCurveOptimized(plist, t, preComb)
	local n = #plist - 1
	local x, y = 0, 0

	preComb = preComb or GameUtil.precomputeCombination(n)

	for i = 0, n do
		local bern = preComb[i] * t^i * (1 - t)^(n - i)

		x = x + plist[i + 1].x * bern
		y = y + plist[i + 1].y * bern
	end

	return x, y
end

function GameUtil.bezierThroughPoints(posList)
	if posList == nil or #posList < 3 then
		return
	end

	local _beziers = {}
	local p0 = posList[1]
	local p1 = posList[2]
	local p2 = posList[3]
	local len = #posList

	if len > 2 then
		local tem = {}

		table.insert(tem, p0)
		table.insert(tem, p1 - (p2 - p0) / 4)
		table.insert(tem, p1)
		table.insert(_beziers, tem)

		for i = 2, len - 1 do
			p0 = posList[i]
			p1 = posList[i] + (posList[i] - _beziers[i - 1][2])
			p2 = posList[i + 1]

			local tem = {}

			table.insert(tem, p0)
			table.insert(tem, p1)
			table.insert(tem, p2)
			table.insert(_beziers, tem)
		end
	else
		local tem = {}

		table.insert(tem, p0)
		table.insert(tem, (p0 + p1) / 2)
		table.insert(tem, p1)
		table.insert(_beziers, tem)
	end

	return _beziers
end

function GameUtil.getBezierThroughCurPoint(t, _beziers)
	if _beziers and #_beziers > 0 then
		local segments = #_beziers
		local idx = 0

		idx = t < 0 and 0 or t >= 1 and segments - 1 or math.floor(segments * t)

		if t >= 1 then
			return _beziers[segments][3]
		end

		local rt = 1 / segments

		t = (t - idx * rt) * segments

		local b = _beziers[idx + 1]

		return b[1] + ((b[2] - b[1]) * 2 * (1 - t) + (b[3] - b[1]) * t) * t
	end
end

function GameUtil.getBoundingMinMaxPos(rtf, containChilds)
	local layers = rtf.transform:GetComponentsInChildren(goutil.Type_RectTransform, true)
	local len = layers.Length

	if len == 0 then
		return Vector3.zero, Vector3.zero
	end

	local minPoint = Vector3.New(math.huge, math.huge, math.huge)
	local maxPoint = Vector3.New(-math.huge, -math.huge, -math.huge)

	for i = 0, len - 1 do
		local layer = layers[i]
		local corners = System.Array.CreateInstance(typeof(UnityEngine.Vector3), 4)

		layer:GetWorldCorners(corners)

		for j = 0, corners.Length - 1 do
			local corner = corners[j]

			minPoint = Vector3.Min(minPoint, corner)
			maxPoint = Vector3.Max(maxPoint, corner)
		end

		if not containChilds then
			break
		end
	end

	return minPoint, maxPoint
end

function GameUtil.AdjustWithSize(adjustGraphicGo, screenPos, sizeX, sizeY, screenWidth, screenHeight, containChilds)
	local _transform = adjustGraphicGo.transform
	local _parentTransform = _transform.parent.transform
	local localPoint = goutil.screenToLocalPos(screenPos, _parentTransform)
	local layers = _transform:GetComponentsInChildren(typeof(UnityEngine.UI.LayoutGroup), true)

	for i = 0, layers.Length - 1 do
		local layout = layers[i]

		if layout.enabled then
			layout:CalculateLayoutInputHorizontal()
			layout:CalculateLayoutInputVertical()
			layout:SetLayoutHorizontal()
			layout:SetLayoutVertical()
		end
	end

	local fitters = _transform:GetComponentsInChildren(typeof(UnityEngine.UI.ContentSizeFitter), true)

	for i = 0, fitters.Length - 1 do
		local fitter = fitters[i]

		if fitter.enabled then
			fitter:SetLayoutHorizontal()
			fitter:SetLayoutVertical()
		end
	end

	local halfWidth = screenWidth * 0.5
	local halfHeight = screenHeight * 0.5
	local leftX = localPoint.x - sizeX * 0.5
	local left = halfWidth + leftX
	local rightX = localPoint.x + sizeX * 0.5
	local right = halfWidth - rightX
	local topY = localPoint.y + sizeY * 0.5
	local p
	local minPos, maxPos = GameUtil.getBoundingMinMaxPos(_transform, containChilds)
	local localPosMin = _transform:InverseTransformPoint(minPos)
	local localPosMax = _transform:InverseTransformPoint(maxPos)
	local gWidth = localPosMax.x - localPosMin.x

	p = gWidth <= right and Vector3.New(rightX - localPosMin.x, topY - localPosMax.y, 0) or gWidth < left and Vector3.New(leftX - localPosMax.x, topY - localPosMax.y, 0) or left <= right and Vector3.New(rightX + -localPosMin.x, topY - localPosMax.y, 0) or Vector3.New(leftX - localPosMax.x, topY - localPosMax.y, 0)

	if p.y + localPosMin.y < -halfHeight then
		p.y = math.min(-halfHeight - localPosMin.y + 10, halfHeight - localPosMax.y)
	end

	if halfHeight < p.y + localPosMax.y then
		p.y = halfHeight - localPosMax.y
	end

	Framework.TransformUtil.SetLocalPos(_transform, p.x, p.y, p.z)
end

function GameUtil.zhAttrName2Lang(zhAttrName)
	local idx = table.indexof(GameEnum.AttrTypeName, zhAttrName)

	if idx then
		return ConstString.Attr[idx]
	end

	return zhAttrName
end

function GameUtil.zhRaceName2Lang(zhRaceName)
	local idx = GameEnum.Races[zhRaceName]

	if idx then
		return ConstString.Race[idx]
	end

	return zhRaceName
end

function GameUtil.zhJobName2Lang(zhJobName)
	local idx = GameEnum.JobZh[zhJobName]

	if idx then
		return ConstString.JobIdxToStr[idx]
	end

	return zhJobName
end

function GameUtil.zhAssignmentConditonText2Lang(zhConditionText)
	local idx

	for k, v in pairs(GameEnum.AssignmentConditionText) do
		if v == zhConditionText then
			idx = k

			break
		end
	end

	if idx then
		return ConstString.AssignmentConditionText[idx]
	end

	return zhConditionText
end

return GameUtil
