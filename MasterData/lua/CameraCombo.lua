--自定义镜头

local data;

function Awake()
    CameraMgr:SetCamera(this);

    local goRT = CSAPI.GetGlobalGO("CommonRT")
	CSAPI.SetCameraRenderTarget(gameObject,goRT);
end

function SetComboer(character)
    --comboer = character;
    CSAPI.SetParent(character.gameObject,actorPos,true);
end
function SetComboTarget(character)
    --comboTarget = character;
    CSAPI.SetParent(character.gameObject,targetPos,true);
end
--移除
function Remove()  
   CameraMgr:ResetCamera(this);
   CSAPI.RemoveGO(gameObject);    
end
