
local deviceType = CSAPI.GetDeviceType()
local perPos, pos = nil, nil

function Awake()
	Input, GetMouseButton, GetMouseButtonDown, GetMouseButtonUp, Physics = UIUtil:GetFuncs()
end

-- _data 自定义数据 DormLayout-》baseTypeDatas
function Refresh(_data)
	m_cfg = _data
	layer = DormMgr:GetDormLayer(m_cfg)
	--icon
	SetIcon(m_cfg.icon)
	-- --scale
	-- if(m_cfg.sType == DormFurnitureType.wall or m_cfg.sType == DormFurnitureType.ground) then
	-- 	CSAPI.SetText(txtScale, "all")
	-- else
	-- 	CSAPI.SetText(txtScale, m_cfg.scale[1] .. "/" .. m_cfg.scale[2] .. "/" .. m_cfg.scale[3])
	-- end
	--name
	--CSAPI.SetText(txtName, m_cfg.sName)
end

function SetIcon(iconName)
	CSAPI.SetGOActive(icon, iconName ~= nil)
	if(iconName) then
		ResUtil.Furniture:Load(icon, iconName .. "")
	end
end

function Update()
	if(deviceType == 3) then
		if(GetMouseButton(0)) then
			pos = Input.mousePosition
		end
	else
		if(Input.touchCount > 0) then
			pos = Input.GetTouch(0).position
		end
	end
	if(pos and pos ~= perPos) then
		CSAPI.SetToMousePosition(transform.parent.transform, transform, pos.x, pos.y, pos.z)
		local ray = DormMgr:GetSceneCamera():ScreenPointToRay(pos)
		local hits = Physics.RaycastAll(ray, 1000, 1 << layer)
		if(hits and hits.Length > 0) then
			local scale = DormMgr:GetDormScale()
			local point = hits[0].point
			local planeType = 1 --所在墙壁
			local _point = {x = point.x, y = point.y, z = point.z}
			if(layer == DormLayer.ground) then
				_point.y = 0
				planeType = 1
			else
				if(hits[0].transform.localPosition.z == 0) then
					_point.x = scale.x * 0.5
					planeType = 2
				else
					_point.z = - scale.z * 0.5
					planeType = 3
				end
			end
			--隐藏自身，隐藏列表，生成3dItem
			local _data = {m_cfg.id, _point, planeType, 0}
			local _datas = {_data, true}
			EventMgr.Dispatch(EventType.Dorm_Furniture_Add, _datas) --推送到DormMain 生成3d物体
			CSAPI.SetGOActive(gameObject, false)
		end	
		perPos = pos
		pos = nil
	end
end

function OnDestroy()    
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
bg=nil;
icon=nil;
txtScale=nil;
txtName=nil;
view=nil;
end
----#End#----