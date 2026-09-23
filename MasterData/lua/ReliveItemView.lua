--复活界面

function Awake()
    CSAPI.SetGOActive(mask,false);
end

function Set(data,callBack)      
    characterGoodsData = CharacterGoodsData(data);   
    --LogError(data);
    local cfgModel = characterGoodsData:GetModelCfg();   
    ResUtil.RoleCard:Load(icon, cfgModel.icon);
    --检测是否有符合复活的位置
    --local isCanRelive = false;
    local placeHolderInfo = characterGoodsData:GetPlaceHolderInfo();       
    local cfg = FightGroundMgr:GetCfg();
    for i = 1,cfg.myRow do
        for j = 1,cfg.myCol do
            --isCanRelive = FightGroundMgr:CheckPutIn(i,j,data.teamId,placeHolderInfo);
            if(isCanRelive)then
                break;
            end
        end
    end

    --CSAPI.SetGOActive(mask,not isCanRelive);

    clickCallBack = callBack;
end

function OnClick()
    if(clickCallBack)then
        clickCallBack(characterGoodsData);
    end
end