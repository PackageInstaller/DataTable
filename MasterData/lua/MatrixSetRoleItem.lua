--房间驻员
--{data = , curlv= , openlv = }  data=> 服务器
local isCalTime = false
local len = 0
local timer = 0
local needToCheckMove = false
function Awake()
    luaTextMove = LuaTextMove.New()
    luaTextMove:Init(txtName)
end 

-- function Awake()
-- 	outlineBar = ComUtil.GetCom(hp, "OutlineBar")
-- end
function SetClickCB(_cb)
	cb = _cb
end

-- function Awake()
-- 	p_slider = ComUtil.GetCom(Slider, "Slider")
-- end
function Refresh(_data, _matrixData)
	cRoleID = _data.data
	curLv = _data.curLv
	openLv = _data.openLv
	--oldTime = _matrixData:GetOldTime()
	--roomID = _matrixData:GetId()
	cRoleData = cRoleID and CRoleMgr:GetData(cRoleID) or nil
	
	local isEmpty = cRoleData == nil and true or false
	CSAPI.SetGOActive(empty, isEmpty)
	CSAPI.SetGOActive(entity, not isEmpty)
	
	local name = ""
	local lockStr = ""
	local abilityName = ""
	local abilityLv = 1
	local lv = 0
	local iconName = nil
	if(not isEmpty) then
		name = cRoleData:GetAlias()
		cfg = cRoleData:GetAbilityCurCfg()
		abilityName = cfg.remarks
		abilityLv = cfg.index
		lv = cRoleData:GetLv()--cfg.index
		iconName = cRoleData:GetIcon()
		--iconName = StringUtil:StrReplace(_iconName, "_shead", "_fhead")
	else
		CSAPI.SetGOActive(imgEmpty, openLv ~= - 1 and curLv >= openLv)
		CSAPI.SetGOActive(lock, openLv ~= - 1 and curLv < openLv)
		if(openLv == - 1) then
			lockStr = LanguageMgr:GetByID(10062)
		elseif(curLv >= openLv) then
			--闲置中
			lockStr = LanguageMgr:GetByID(10063)
		else
			--锁住
			lockStr = LanguageMgr:GetByID(10040, openLv)
		end
	end
	SetName(name)
	SetLockStr(lockStr)
	SetIcon(iconName)
	SetAbility(abilityName, abilityLv)
	SetLv(lv)
	InitPl() --pl face
	
	local bgName = isEmpty and "img_72_02.png" or "img_72_01.png"
	CSAPI.LoadImg(clickNode, "UIs/Matrix/" .. bgName, true, nil, true)
end

function SetName(name)
	needToCheckMove = false
	CSAPI.SetText(txtName, name)
	needToCheckMove = true
end

function SetIcon(iconName)
	CSAPI.SetGOActive(icon, iconName ~= nil)
	if(iconName ~= nil) then
		ResUtil.Card:Load(icon, iconName, true)
	end
end

--在宿舍不显示
function SetAbility(str, lv)
	if(cRoleData and cRoleData:IsInBuilding()) then 
		str = string.format("%sLV%s", str, lv)
		CSAPI.SetText(txtAbility, str)
	else 
		CSAPI.SetText(txtAbility, "")
	end 
end

function SetLv(lv)
	CSAPI.SetGOActive(imgLove, lv ~= 0)
	if(lv ~= 0) then
		CSAPI.SetText(txtLove, lv .. "")
	end
end


function SetLockStr(str)
	CSAPI.SetText(txtLock, str)
end

--选择驻员
function OnClick()
	if(openLv ~= - 1 and curLv >= openLv) then
		cb(1)
	end
end

--移除
function OnClickRemove()
	if(cRoleData) then
		cb(2, cRoleData)
	end
end


--=====================================pl=========================================================
function InitPl()
	if(matrixPL == nil) then
		matrixPL = MatrixPL.New()
	end
	matrixPL:Init(cRoleData, face, txtPL, slider, imgSlider)
end

function Update()
	if(matrixPL) then
		matrixPL:Update()
	end
	if (needToCheckMove) then
        luaTextMove:CheckMove(txtName)
        needToCheckMove = false
    end
end

-- function InitPl()
-- 	plTimer = nil
-- 	if(cRoleData) then
-- 		plPerTimer = cRoleData:GetPerTimer()
-- 		if(plPerTimer and plPerTimer > 0) then
-- 			plTimer = Time.time + plPerTimer
-- 		end
-- 	end
-- end
-- function Update()
-- 	if(plTimer and Time.time > plTimer) then
-- 		plTimer = Time.time + plPerTimer
-- 		SetPL()
-- 	end
-- end
-- function SetPL()
-- 	if(cRoleData) then
-- 		local curTv = cRoleData:GetCurRealTv()
-- 		CSAPI.SetText(txtPL, string.format("%s/%s", curTv, 100))
-- 		local faceName = MatrixMgr:GetFaceName(curTv)
-- 		ResUtil.Face:Load(face, faceName)
-- 	end
-- end
-- function InitPl()
-- 	isCalTime = false
-- 	if(cRoleData) then
-- 		InitPLFace(true, cRoleData, oldTime)
-- 		isCalTime = true
-- 	end
-- end
-- function InitPLFace(b, cRoleData, oldTime)
-- 	CSAPI.SetGOActive(plObj, b)
-- 	if(matrixPL == nil) then
-- 		matrixPL = MatrixPL.New()
-- 	end
-- 	if(b) then
-- 		matrixPL:InitTime(b, cRoleData:GetTF(), cRoleData:GetTriedValue(), oldTime, face, txtPL)
-- 	end
-- end
-- function Update()
-- 	if(isCalTime and matrixPL) then
-- 		matrixPL:Update()
-- 		local cur = matrixPL:GetInfo()
-- 		--bar
-- 		if(self.oldCur == nil or self.oldCur ~= cur) then
-- 			self.oldCur = cur
-- 			outlineBar:SetProgress(cur and cur / 100 or 0)
-- 			local code = "FFFFFF"
-- 			if(num >= 100) then
-- 				code = "FF0040"
-- 			elseif(num >= 50) then
-- 				code = "FFC146"
-- 			end
-- 			CSAPI.SetTextColorByCode(imgSlider, code)
-- 		end
-- 	end
-- end
