--弹珠
local isRun = false
local shootTime = 0
local triggerList = nil --碰触列表


function Awake()
	rig = bg:GetComponent("Rigidbody2D")
end

function Init(_fLua)
	fLua = _fLua
end

function Refresh(_cardData)
	CSAPI.SetAnchor(gameObject, 0, 0, 0)
	CSAPI.SetGOActive(gameObject, false)
	
	cardData = _cardData
	AddHead()
end

function AddHead()
	if(not head) then
		ResUtil:CreateUIGOAsync("Matrix/MatrixMiniGameHead", bg, function(go)
			head = ComUtil.GetLuaTable(go)
			head.Refresh2(cardData)
		end)
	else
		head.Refresh2(cardData)
	end
end

function Update()
	if(isRun) then
		if(((Time.time - shootTime) > 2) and UnityEngine.Vector2.Distance(rig.velocity, UnityEngine.Vector2.zero) <= 1) then
			isRun = false
			rig.velocity = UnityEngine.Vector2.zero
			fLua.BallEndCB(triggerList)
		end
	end
end

--发射
function Shoot(dir)
	CSAPI.SetGOActive(gameObject, true)
	triggerList = {}
	shootTime = Time.time
	rig.drag = 1
	rig:AddForce(dir)
	isRun = true
end

function OnTriggerEnter2D(tab, colName)
	if(tab.GetType) then
		local type = tab.GetType()
		if(type == 5) then
			rig.drag = tab.cfg.drag
		else	
			local keys = tab.GetIDIndex()
			local key = keys[1] .. "_" .. keys[2]
			if(not triggerList[key]) then
				triggerList[key] = keys
			end

			if(type == 4) then
				--卫星
               fLua.ColWithASatellite()
			   tab.Hide()
			end
		end
	end
	if(colName and colName == "d0") then
		fLua.ActivateD0(true)
	end
end

function OnTriggerExit2D(tab, colName)
	if(tab.GetType) then
		local type = tab.GetType()
		if(type == 5) then
			rig.drag = 1
		end
	end
end
