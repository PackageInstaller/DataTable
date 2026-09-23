--天空盒

function Awake()
    SkyBoxMgr:SetCurrSkyBox(gameObject);
    CSAPI.RemoveGO(gameObject);
end