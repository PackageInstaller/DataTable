--gameitem  多语言 调试
--远征小游戏
--小球高度第一到达完全脱离底部时再启用底部碰撞
local angleLimit = {- 72, 72} --箭头角度范围
local sliderLimit = {0.08, 0.92} --力度滑动条范围： 0.08 -》 0.92  
local forceLimit = {0, 1500}      --力度范围（对应进度条范围）

local ShootState = {
	Start = 1,
	Wait = 2,
	Shooting = 3,
}
local curState = nil
local isChangeAngle = 0  -- -1:左边  1：右边
local isPress = false
local curIndex = 1
local satelliteNum = 0  --收集到的卫星数量

function Awake()
	slider_force = ComUtil.GetCom(forceSlider, "Image")
	rect = ComUtil.GetCom(arrow, "RectTransform")
	
	CSAPI.SetGOActive(mask, true)
	
	UIUtil:AddTop2("RoleListNormal", bg, function()
		view:Close()
	end, nil, {})
end


--info =>MatrixExpeditionInfo
function OnOpen()
	info = data.data
	selectCardDatas = data.selectCardDatas
	
	ballCount = info:GetBallCount()
	curState = ShootState.Wait
	
	InitPanel()
	RefreshPanel()
end

function Update()
	if(curState == ShootState.Wait) then
		--角度
		if(isChangeAngle == - 1) then
			local z = rect.eulerAngles.z
			if(z > 180) then
				z = z - 360
			end
			z = z + 2
			if(z > angleLimit[2]) then
				z = angleLimit[2]
			end
			rect.eulerAngles = UnityEngine.Vector3(0, 0, z)
		elseif(isChangeAngle == 1) then
			local z = rect.eulerAngles.z
			if(z > 180) then
				z = z - 360
			end
			z = z - 2
			if(z < angleLimit[1]) then
				z = angleLimit[1]
			end
			rect.eulerAngles = UnityEngine.Vector3(0, 0, z)
		end
		
		--力度
		if(isPress) then
			if(isAdd) then			
				slider_force.fillAmount = slider_force.fillAmount + 0.02
				if(slider_force.fillAmount >= sliderLimit[2]) then				
					slider_force.fillAmount = sliderLimit[2]
					isAdd = false
				end
			else
				slider_force.fillAmount = slider_force.fillAmount - 0.02
				if(slider_force.fillAmount <= sliderLimit[1]) then
					slider_force.fillAmount = sliderLimit[1]
					isAdd = true
					
				end
			end
		end
	end
end

function InitPanel()
	if(ballCount > #selectCardDatas) then
		LogError("球数超出卡牌数量！")
		return
	end
	
	--wall(根据分辨率设置wall) c# colliderfit处理
	--生成头像
	AddHeads()
	
	--num
	SetSatelliteNum()
	
	--敌人 
	SetEvents()
end

function SetSatelliteNum()
	CSAPI.SetText(txtNum, satelliteNum .. "")
end

--1 0,0
--2 -16,171
function AddHeads()
	headItems = {}
	for i = ballCount, 2, - 1 do
		ResUtil:CreateUIGOAsync("Matrix/MatrixMiniGameHead", headParent, function(go)
			local tab = ComUtil.GetLuaTable(go)
			local x, y = GetTargetPos(i - 1)
			CSAPI.SetAnchor(go, x, y, 0)
			tab.Refresh(i, selectCardDatas[i], MoveCB)
			table.insert(headItems, tab)
		end)	
	end
end


function MoveHeads()
	CSAPI.SetGOActive(role, false)
	CSAPI.SetGOActive(uis, true)
	for i, v in ipairs(headItems) do
		if(v.index > 1) then
			local x, y = GetTargetPos(v.index - 1)
			v.MoveNext(x, y)
		else
			CSAPI.SetGOActive(v.gameObject, false)
		end
	end
end

function MoveCB()
	curState = ShootState.Wait
	RefreshPanel()
end


function SetRole()
	CSAPI.SetGOActive(role, true)
	--icon
	local _data = selectCardDatas[curIndex]
	local cfg = _data:GetModelCfg()
	ResUtil.FightCard:Load(paintImg, cfg.Fight_head)
	--name
	CSAPI.SetText(txtName, _data:GetName())
	CSAPI.SetText(txtName2, _data:GetEnName())
end

--头像位置 realIndex真实位置，最下面为第一位
function GetTargetPos(realIndex)
	if(realIndex == 1) then
		return 0, 0
	end
	x = - 16
	y = 171 +(realIndex - 2) * 41
	return x, y
end

--远征事件
function SetEvents()
	local eventId = info:GetCfg().eventId
	local index = nil
	local items = {}
	for i, v in ipairs(eventId) do
		local cfg = Cfgs.CfgExpeditionEvent:GetByID(v)
		ItemUtil.AddItems("Matrix/MatrixMiniGameItem", items, cfg.infos, eventParent, nil, 1, v)
	end
end

function RefreshPanel()
	if(curState == ShootState.Start) then
		--移动小球（移动后隐藏）
		MoveHeads()
	elseif(curState == ShootState.Wait) then
		--操作阶段，等待玩家调整角度力度
		--mask
		CSAPI.SetGOActive(mask, false)	
		--arrow 
		CSAPI.SetRectAngle(arrow, 0, 0, angleLimit[2])	
		--slider
		slider_force.fillAmount = sliderLimit[1]	
		--d
		ActivateD0(false)
		--role
		SetRole()	
		--装填
		AddBall()
	elseif(curState == ShootState.Shooting) then
		CSAPI.SetGOActive(mask, true)
		Shoot()
	end
end

--发射
function Shoot()
	--隐藏部分UI
	CSAPI.SetGOActive(uis, false)
	--dir
	local x1, y1 = CSAPI.GetPos(arrow)
	local x2, y2 = CSAPI.GetPos(barrel)
	local direction = UnityEngine.Vector2(x2 - x1, y2 - y1).normalized
	--force
	local sliderValue = slider_force.fillAmount < 0.1 and 0.1 or slider_force.fillAmount  --力度
	local force =(forceLimit[2] - forceLimit[1]) *(sliderValue - sliderLimit[1]) /(sliderLimit[2] - sliderLimit[1])
	
	ball.Shoot(direction * force)
end


--激活底部碰撞
function ActivateD0(b)
	CSAPI.SetGOActive(d0, not b)
	CSAPI.SetGOActive(d, b)
end

--碰到卫星
function ColWithASatellite()
	satelliteNum = satelliteNum + 1
	SetSatelliteNum()
end

--小球运动结束
function BallEndCB(keys)
	allKeys = allKeys or {}
	for i, v in pairs(keys) do
		table.insert(allKeys, v)
	end
	if(curIndex < ballCount) then
		curIndex = curIndex + 1
		curState = ShootState.Start
		RefreshPanel()
	else
		--无球了
		local _events = {}
		for i, v in ipairs(allKeys) do
			if(_events[v[1]]) then
				table.insert(_events[v[1]], v[2])
			end
		end
		local events = {}
		for i, v in pairs(events) do
			local tab = {}
			tab.id = i
			tab.indexs = v
			table.insert(events, tab)
		end
		--info.OkCB(events)
		BuildingProto:StartExpedition(info:GetBuildID(), info:GetServerData().cfgId, info:GetServerData().id, GetCids(), events)
		view:Close()
	end
end

--添加球
function AddBall()
	if(not ball) then
		local go = ResUtil:CreateUIGO("Matrix/MatrixMiniGameBall", ballParent.transform)
		ball = ComUtil.GetLuaTable(go)
		ball.Init(this)
	end
	ball.Refresh(selectCardDatas[curIndex])
end


--重置界面
function Reset()
	--枪
	isChangeAngle = 0
	CSAPI.SetRectAngle(arrow, 0, 0, 0)  --旋转
	CSAPI.SetAnchor(barrel, 0, - 13, 0)  --撞针
	--进度条
	slider_force.fillAmount = 0
	--col
	CSAPI.SetGOActive(wallD1, true)
	CSAPI.SetGOActive(wallD2, false)
	if(ball) then
		CSAPI.SetAnchor(ball.gameObject, false)
	end
	--state
	curState = ShootState.Start
end


function GetCids()
	local ids = {}
	for i, v in ipairs(selectCardDatas) do
		table.insert(ids, v:GetID())
	end
	return ids
end


--左
function OnPressDownLeft()
	if(curState == ShootState.Wait) then
		isChangeAngle = - 1
	end
end
function OnPressUpLeft()
	if(curState == ShootState.Wait) then
		isChangeAngle = 0
	end
end

--右
function OnPressDownRight()
	if(curState == ShootState.Wait) then
		isChangeAngle = 1
	end
end
function OnPressUpRight()
	if(curState == ShootState.Wait) then
		isChangeAngle = 0
	end
end

--弹射
function OnPressDownShoot()
	if(curState == ShootState.Wait) then
		isAdd = true
		isPress = true
	end
end
function OnPressUpShoot()
	if(curState == ShootState.Wait) then
		isPress = false
		isChangeAngle = 0
		curState = ShootState.Shooting
		RefreshPanel()
	end
end

--自动弹射
function OnClickShoot2()
	isChangeAngle = 0
	--角度
	local angle = CSAPI.RandomInt(angleLimit[1], angleLimit[2])
	CSAPI.SetRectAngle(arrow, 0, 0, angle)
	--力度
	local sliderValue = CSAPI.RandomFloat(sliderLimit[1], sliderLimit[2])
	slider_force.fillAmount = sliderValue
	
	curState = ShootState.Shooting
	RefreshPanel()
end

--返回
function OnClickBack()
	local dialogdata = {};
	dialogdata.content = "退出后，本次探索任务将会消失，是否退出？"
	dialogdata.okCallBack = function()
		BuildingProto:DelExpTask(info:GetBuildID(), info:GetServerData().cfgId, info:GetServerData().id)
		view:Close()
	end
	CSAPI.OpenView("Dialog", dialogdata)
end

