--基地格子
--local textMesh
local data = nil

function Awake()
	--textMesh = ComUtil.GetCom(num, "TextMesh")
end

function SetData(_data)
	data = _data
	--SetPosNum()

	InitRes()
	SetLightState(0)
end

--初始化资源
function InitRes()   
    local res = "Part3/part3_05"
    if(res)then
        CSAPI.CreateGOAsync("Grids/" .. res, 0, 0, 0, node);
    end
end

--设置高亮状态
--state：
--0：关闭
--1：绿色
--2：红色
function SetLightState(state)
    state = state or 0;
    CSAPI.SetGOActive(our,state == 1);
    CSAPI.SetGOActive(enemy,state == 2);
    currLightState = state;
end

-- function SetPosNum()
-- 	local x, y, z = CSAPI.GetPos(gameObject)
-- 	x = math.ceil(x)
-- 	z = math.ceil(z)
-- 	textMesh.text = "id:" .. data.id .. "\nx:" .. x .. "\nz:" .. z
-- end 