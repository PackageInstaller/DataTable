--事件 
--[[/// 0：固定位置
///1：来回移动
///2：重复移动
///3、椭圆
///4、不规则
///5、障碍区
]]
local isIn = false
local ellipseNum = 100 --椭圆划分份数
local tracksNum = 100 --一段规则划分份数

local curTime = 0
local moveSpeed = 0

local moveOnPathDis = 0       --当前移动的距离
local moveOnPathTotalDis = 0  --路径长度
local isForward = true        --正向移动


function OnDestroy()
	isIn = false
end

function Update()
	if(isIn) then
		if(cfg.nType == 1) then
			Move1()
		elseif(cfg.nType == 2) then
			Move2()
		elseif(cfg.nType == 3) then
			Move3()
		elseif(cfg.nType == 4) then
			Move4()
		end
	end
end

function Refresh(_data, _id)
	cfg = _data
	id = _id
	Init()
end

function Init()
	--bg 
	CSAPI.SetRTSize(bg, cfg.radius, cfg.radius)
	local collider = ComUtil.GetCom(bg, "Collider2D")
	collider.radius = cfg.radius / 2
	
	--bg
	ResUtil.Expedition:Load(bg, cfg.sBg)
	ResUtil.Expedition:Load(bg2, cfg.sBg .. "_1")
	--icon 
	local iconName = cfg.sIcon
	if(cfg.nType == 4 or cfg.nType == 5) then
		iconName = cfg.nType == 4 and "expedition_02" or "expedition_01"
	end
	ResUtil.IconGoods:Load(icon, iconName)
	--pos
	CSAPI.SetAnchor(gameObject, cfg.pos[1], cfg.pos[2], 0)
	--InitByType
	if(cfg.nType == 0) then
		--SetBGColor(255, 255, 255)
	elseif(cfg.nType == 1) then
		--SetBGColor(0, 0, 255)
		SetABPos()	
	elseif(cfg.nType == 2) then
		--SetBGColor(0, 255, 255)
		SetABPos()
	elseif(cfg.nType == 3) then
		--SetBGColor(0, 255, 0)
		SetEllipsePos()
	elseif(cfg.nType == 4) then
		--SetBGColor(255, 210, 0)
		SetBezierPathPos()
	elseif(cfg.nType == 5) then
		--SetBGColor(255, 0, 0)
	end
	isIn = true
end

--计算速度
function CalSpeed()
	curTime = curTime + Time.deltaTime
	moveSpeed = cfg.speed_min + cfg.accelerated * curTime
	if(cfg.accelerated > 0 and moveSpeed > cfg.speed_max) then
		moveSpeed = cfg.speed_max	
	elseif(cfg.accelerated < 0 and moveSpeed < cfg.speed_max) then	
		moveSpeed = cfg.speed_max
	end
end

--来回移动
function Move1()
	CalSpeed()
	local bgPosX, bgPosY, z = CSAPI.GetAnchor(bg)
	local pos = nil
	if(isForward) then
		pos = UnityEngine.Vector2.MoveTowards(UnityEngine.Vector2(bgPosX, bgPosY), anchoredPositionB, moveSpeed * Time.deltaTime)
	else
		pos = UnityEngine.Vector2.MoveTowards(UnityEngine.Vector2(bgPosX, bgPosY), anchoredPositionA, moveSpeed * Time.deltaTime)
	end
	CSAPI.SetAnchor(bg, pos.x, pos.y, z)
	if(pos == anchoredPositionA or pos == anchoredPositionB) then
		curTime = 0
		isForward = not isForward
	end
end
--A移动到B
function Move2()
	CalSpeed()
	local bgPosX, bgPosY, z = CSAPI.GetAnchor(bg)
	local pos = UnityEngine.Vector2.MoveTowards(UnityEngine.Vector2(bgPosX, bgPosY), anchoredPositionB, moveSpeed * Time.deltaTime)
	CSAPI.SetAnchor(bg, pos.x, pos.y, z)
	if(pos == anchoredPositionB) then
		curTime = 0
		CSAPI.SetAnchor(bg, anchoredPositionA.x, anchoredPositionA.y, z)
	end
end
--椭圆
function Move3()
	CalSpeed()
	moveOnPathDis = moveOnPathDis + Time.deltaTime * moveSpeed
	if(moveOnPathDis > moveOnPathTotalDis) then
		moveOnPathDis = moveOnPathDis - moveOnPathTotalDis
	end
	local pos = GetCurPosByLerp(moveOnPathDis / moveOnPathTotalDis)
	CSAPI.SetAnchor(bg, pos.x, pos.y, 0)
end

--不规则移动（来回）
function Move4()
	if(moveOnPathDis < moveOnPathTotalDis) then
		CalSpeed()
		moveOnPathDis = moveOnPathDis + Time.deltaTime * moveSpeed
		if(isForward) then	
			local pos = GetCurPosByLerp(moveOnPathDis / moveOnPathTotalDis)
			CSAPI.SetAnchor(bg, pos.x, pos.y, 0)
		else
			local pos = GetCurPosByLerp2(moveOnPathDis / moveOnPathTotalDis)
			CSAPI.SetAnchor(bg, pos.x, pos.y, 0)
		end
	else
		curTime = 0
		moveOnPathDis = 0
		isForward = not isForward
	end
end

local currentPoint = UnityEngine.Vector2(0, 0)
local nextPoint = UnityEngine.Vector2(0, 0)

--获取当前位置
function GetCurPosByLerp(t)
	if(t > 1) then
		t = 1
	end
	local disRatio = moveOnPathTotalDis * t
	local pointsDis = 0
	local ratio = 0
	local len = #totalPos
	for i = 1, len - 1 do
		local pointDis = UnityEngine.Vector2.Distance(totalPos[i], totalPos[i + 1])
		pointsDis = pointsDis + pointDis
		if(pointsDis >= disRatio) then
			currentPoint = totalPos[i]
			nextPoint = totalPos[i + 1]
			ratio =(disRatio -(pointsDis - pointDis)) / pointDis
			break
		end
	end
	--看向下一个点
	--LookNext(nextPoint)
	return UnityEngine.Vector2.Lerp(currentPoint, nextPoint, ratio)
end
--获取当前位置 反向
function GetCurPosByLerp2(t)
	if(t > 1) then
		t = 1
	end
	local disRatio = moveOnPathTotalDis * t
	local pointsDis = 0
	local ratio = 0
	local len = #totalPos
	for i = len, 2, - 1 do
		local pointDis = UnityEngine.Vector2.Distance(totalPos[i - 1], totalPos[i])
		pointsDis = pointsDis + pointDis
		if(pointsDis >= disRatio) then
			currentPoint = totalPos[i]
			nextPoint = totalPos[i - 1]
			ratio =(disRatio -(pointsDis - pointDis)) / pointDis
			break
		end
	end
	--看向下一个点
	--LookNext(nextPoint)
	return UnityEngine.Vector2.Lerp(currentPoint, nextPoint, ratio)
end

--朝向
function LookNext(nextPoint)
	local x, y = CSAPI.GetPos(bg)
	local angle = UnityEngine.Vector2.SignedAngle(UnityEngine.Vector2(x, y), nextPoint) --得到围绕z轴旋转的角度
	local rotation = UnityEngine.Quaternion.Euler(0, 0, angle) --将欧拉角转换为四元数
	CSAPI.SetRectAngle(bg, 0, 0, angle)
end


-- --icon颜色
-- function SetBGColor(r, g, b, a)
-- 	a = 255
-- 	CSAPI.SetImgColor(bg, r, g, b, a)
-- end
--AB点位置
function SetABPos()
	anchoredPositionA = UnityEngine.Vector2(cfg.pos1[1], cfg.pos1[2])
	anchoredPositionB = UnityEngine.Vector2(cfg.pos2[1], cfg.pos2[2])
end
--椭圆坐标集
function SetEllipsePos()
	totalPos = {}
	local isClockwise = cfg.clockwise and cfg.clockwise or 1
	for i = 0, ellipseNum do
		local angle = isClockwise == 1 and(ellipseNum - i) * 2 * math.pi / ellipseNum or i * 2 * math.pi / ellipseNum
		local x = cfg.radius_w * math.cos(angle)
		local y = cfg.radius_h * math.sin(angle)
		table.insert(totalPos, UnityEngine.Vector2(x, y))
	end
	--长度
	local length = #totalPos
	for i = 1, length - 1 do
		moveOnPathTotalDis = moveOnPathTotalDis + UnityEngine.Vector2.Distance(totalPos[i], totalPos[i + 1])
	end
end
--不规则位置集合
function SetBezierPathPos()
	local sTracks = cfg.sTracks
	totalPos = {}
	local allPos = SetBezierPathPoint(sTracks)
	local len = #allPos - 1
	for i = 1, len do
		SetBezier(allPos[i].point, allPos[i].f, allPos[i + 1].b, allPos[i + 1].point)
	end
	table.insert(totalPos, allPos[#allPos].point)
	--长度
	local length = #totalPos - 1
	for i = 1, length do
		moveOnPathTotalDis = moveOnPathTotalDis + UnityEngine.Vector2.Distance(totalPos[i], totalPos[i + 1])
	end
end

--曲线所有的点
function SetBezier(p0, p1, p2, p3)
	for i = 0, tracksNum - 1 do
		local ratio = i / tracksNum
		local p0_1 = UnityEngine.Vector2.Lerp(p0, p1, ratio)
		local p1_2 = UnityEngine.Vector2.Lerp(p1, p2, ratio)
		local p2_3 = UnityEngine.Vector2.Lerp(p2, p3, ratio)
		local p0_1_1_2 = UnityEngine.Vector2.Lerp(p0_1, p1_2, ratio)
		local P1_2_2_3 = UnityEngine.Vector2.Lerp(p1_2, p2_3, ratio)
		local p0_1_1_2_1_2_2_3 = UnityEngine.Vector2.Lerp(p0_1_1_2, P1_2_2_3, ratio)
		table.insert(totalPos, p0_1_1_2_1_2_2_3)
	end
end

--设置轨迹节点
function SetBezierPathPoint(sTracks)
	local allPos = {}
	local points = StringUtil:split(sTracks, "|")
	for i, v in ipairs(points) do
		local posList = StringUtil:split(v, ";")
		local _pos = {}
		for k, m in ipairs(posList) do
			local pos = StringUtil:split(m, ",")
			local _x, _y = tonumber(pos[1]), tonumber(pos[2])
			if(k == 1) then
				_pos.point = UnityEngine.Vector2(_x, _y)
			elseif(k == 2) then
				_pos.f = UnityEngine.Vector2(_x, _y) + _pos.point
			elseif(k == 3) then
				_pos.b = UnityEngine.Vector2(_x, _y) + _pos.point
			end	
		end
		table.insert(allPos, _pos)
	end
	return allPos
end

function GetType()
	return cfg.nType
end
function GetIDIndex()
	return {id, cfg.index}
end

--卫星被碰到则隐藏
function Hide()
	CSAPI.SetGOActive(gameObject, false)
end 

function OnTriggerEnter(tab, colName)
	LogError(2)
end 