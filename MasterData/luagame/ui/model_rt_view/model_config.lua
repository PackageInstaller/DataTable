local M = {}
M.UI_MAIN_MODEL_PARAM = {
  BG_NAME = "MainBg",
  INIT_CAMERA_PARAM = {
    pos_x = 0,
    pos_y = 0.7,
    pos_z = -3,
    rot_x = 0,
    rot_y = 12.47,
    rot_z = 0
  }
}
M.UI_FASHION_MODEL_PARAM = {
  BG_NAME = "FashionBg",
  INIT_CAMERA_PARAM = {
    pos_x = 0.8,
    pos_y = 0.85,
    pos_z = -3,
    rot_x = 0,
    rot_y = 0,
    rot_z = 0
  },
  FAR_CAMERA_PARAM = {
    pos_x = 0,
    pos_y = 0.7,
    pos_z = -3,
    rot_x = 0,
    rot_y = 0,
    rot_z = 0
  },
  NEAR_CAMERA_PARAM = {
    pos_x = 0,
    pos_y = 1.2,
    pos_z = -1.24,
    rot_x = 0,
    rot_y = 0,
    rot_z = 0
  }
}
M.UI_SELECTHERO_MODEL_PARAM = {
  BG_NAME = "SelectHeroBg",
  INIT_CAMERA_PARAM = {
    pos_x = 0,
    pos_y = 0.78,
    pos_z = -2.81,
    rot_x = 0,
    rot_y = 0,
    rot_z = 0
  }
}
M.UI_CHARACTER_ENTER_MODEL_PARAM = {
  BG_NAME = "CharacterEnterBg",
  INIT_CAMERA_PARAM = {
    pos_x = 0,
    pos_y = 1.17,
    pos_z = -1.88,
    rot_x = 0,
    rot_y = 7,
    rot_z = 0
  }
}
M.UI_TESTSHOW_MODEL_PARAM = {
  BG_NAME = "CharacterEnterBg",
  INIT_CAMERA_PARAM = {
    pos_x = -0.3,
    pos_y = 0.78,
    pos_z = -2.54,
    rot_x = 0,
    rot_y = 7,
    rot_z = 0
  }
}
M.UI_CHARACTER_MODEL_PARAM = {
  BG_NAME = "CharacterBg",
  INIT_CAMERA_PARAM = {
    pos_x = 0,
    pos_y = 1.17,
    pos_z = -1.88,
    rot_x = 0,
    rot_y = 7,
    rot_z = 0
  }
}
M.UI_TEAM_MODEL_PARAM = {
  BG_NAME = "TeamBg",
  INIT_CAMERA_PARAM = {
    pos_x = 0.48,
    pos_y = 1.01,
    pos_z = -3.98,
    rot_x = 0,
    rot_y = 0,
    rot_z = 0
  },
  MUL_NPC_PARAM = {
    [1] = {
      pos_x = 0,
      pos_y = 0,
      pos_z = -0.43,
      rot_x = 0,
      rot_y = 172.8,
      rot_z = 0
    },
    [2] = {
      pos_x = -1.31,
      pos_y = 0,
      pos_z = 0.12,
      rot_x = 0,
      rot_y = 156,
      rot_z = 0
    },
    [3] = {
      pos_x = 1.13,
      pos_y = 0,
      pos_z = 0,
      rot_x = 0,
      rot_y = 187,
      rot_z = 0
    }
  }
}
M.UI_ENEMY_MODEL_PARAM = {
  BG_NAME = "EnemyInfoBg",
  INIT_CAMERA_PARAM = {
    pos_x = 0,
    pos_y = 1,
    pos_z = -6,
    rot_x = 0,
    rot_y = 0,
    rot_z = 0
  }
}
return M
