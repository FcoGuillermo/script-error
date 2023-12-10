/*
  Script: 1_tx_dar_equipo
  Equipo inicial del aventurero.
*/

//Cuerpo Principal.
void main()
{
    object oPJ = GetPCSpeaker();

    //Cogemos los bonos de las habilidades.
    int iEsaFUE = GetAbilityModifier(ABILITY_STRENGTH, oPJ);
    int iEsaCON = GetAbilityModifier(ABILITY_CONSTITUTION, oPJ);
    int iEsaDES = GetAbilityModifier(ABILITY_DEXTERITY, oPJ);
    int iEsaINT = GetAbilityModifier(ABILITY_INTELLIGENCE, oPJ);
    int iEsaSAB = GetAbilityModifier(ABILITY_WISDOM, oPJ);
    int iEsaCAR = GetAbilityModifier(ABILITY_CHARISMA, oPJ);


    /*
    Dar un poco de oro al Aventurero.
    Alguien carismatico empezara con algo de oro extra.
    */
    int iDineroPJ = GetGold(oPJ);
    if (iDineroPJ<500)
    {
        int iOroInicial = (500 + (iEsaCAR * 100));
        if (iOroInicial < 100) {iOroInicial = 50;}
        GiveGoldToCreature(oPJ, iOroInicial);
    }
    else //Si por lo que sea tiene oro (vuelve aqui por un bug) no recibe nada.
    {
        SendMessageToPC(oPJ, "No has recibido mas oro, tienes el suficiente");
    }

    /*
    Dar algunos PX al Aventurero.
    Recibe un extra de su inteligencia y sabiduria combinadas.
    */

    int iExperienciaInicial = (20000 + ((iEsaINT + iEsaSAB) * 1000));
    SetXP(oPJ, iExperienciaInicial);

    /*
    Damos unos pocos objetos estandar al aventurero.
    */
    CreateItemOnObject("come_trucha", oPJ);
    CreateItemOnObject("come_tortaviaje", oPJ);
    CreateItemOnObject("come_frutossecos", oPJ);
    CreateItemOnObject("come_fruta_1", oPJ);
    CreateItemOnObject("tx_gen_garrote", oPJ);


    /*
    Ahora, dependiendo de la clase del aventurero, recibira otros objetos.
    Especificos para cada profesion.
    */

    //--------------------------------------------------------------------->
    if (GetLevelByClass(CLASS_TYPE_BARBARIAN, oPJ) >= 1)
    {
        //Generico Barbaro.
        CreateItemOnObject("tx_gen_barbaro", oPJ);
        CreateItemOnObject("bebe_grog", oPJ);
        CreateItemOnObject("bebe_orujo", oPJ);

        if(GetRacialType(oPJ)== IP_CONST_RACIALTYPE_HALFORC)
        {

            DestroyObject(GetObjectByTag("tx_gen_barbaro"));
            CreateItemOnObject("tx_coraza_01", oPJ);
        }

        if (iEsaINT>=0)
        {
            CreateItemOnObject("nw_it_mpotion020", oPJ, 3);
            CreateItemOnObject("tx_gen_hachabat", oPJ);
        }//Barbaro Listo.

        if (iEsaSAB>0)
        {
            if(GetRacialType(oPJ)==IP_CONST_RACIALTYPE_HALFORC)
            {
                CreateItemOnObject("tx_esc_paves_02", oPJ);
            }

        }//Barbaro Astuto.

        if (iEsaCAR>0)
        {

        }//Barbaro Carismatico.
    }//fin barbaro.

    //--------------------------------------------------------------------->
    if (GetLevelByClass(CLASS_TYPE_BARD, oPJ) >= 1)
    {
        CreateItemOnObject("NW_IT_MPOTION001", oPJ, 10);
        CreateItemOnObject("nw_it_mpotion020", oPJ, 6);
        CreateItemOnObject("NW_IT_MPOTION002", oPJ, 1);
        CreateItemOnObject("NW_IT_MPOTION006", oPJ, 1);
        CreateItemOnObject("NW_IT_MPOTION011", oPJ, 1);
        CreateItemOnObject("nw_it_mpotion020", oPJ, 1);

        CreateItemOnObject("tx_gen_bardo", oPJ);
        if (iEsaINT>0)
        {
            CreateItemOnObject("tx_cetroescarcha", oPJ);
            CreateItemOnObject("tx_gen_virote", oPJ, 99);
            CreateItemOnObject("tx_gen_virote", oPJ, 99);
            CreateItemOnObject("tx_gen_virote", oPJ, 99);
            CreateItemOnObject("tx_gen_virote", oPJ, 99);
            CreateItemOnObject("tx_gen_ball_leve", oPJ);
        }//Listo.
        if ((iEsaINT>0)&&(iEsaFUE>0))
        {
            DestroyObject(GetObjectByTag("tx_gen_ball_leve"));
            CreateItemOnObject("tx_gen_ball_pesa",oPJ);
        }//Listo y Fuerte.
        if (iEsaSAB>0)
        {
            CreateItemOnObject("tx_gen_daga", oPJ);
            CreateItemOnObject("tx_gen_estoque", oPJ);
        }//Astuto.
        if (iEsaCAR>0)
        {
            CreateItemOnObject("come_huevos",oPJ);
            CreateItemOnObject("come_jamon",oPJ);
            CreateItemOnObject("come_trucha",oPJ);
            CreateItemOnObject("come_platobueno1",oPJ);
            CreateItemOnObject("come_platobueno2",oPJ);
            CreateItemOnObject("bebe_hidromiel",oPJ, 4);
            CreateItemOnObject("bebe_sidra",oPJ, 4);
        }//Carismatico.
    }//fin bardo.

    //--------------------------------------------------------------------->
    if (GetLevelByClass(CLASS_TYPE_CLERIC, oPJ) >= 1)
    {
        CreateItemOnObject("tx_gen_clerigo", oPJ);
        CreateItemOnObject("tx_escudo", oPJ);
        CreateItemOnObject("tx_gen_maza", oPJ);
        CreateItemOnObject("NW_IT_MPOTION001", oPJ);
        if (iEsaINT>0)
        {
            CreateItemOnObject("bebe_zarzaparri1", oPJ, 6);
            CreateItemOnObject("NW_IT_MPOTION020", oPJ, 10);
        }//Listo.
        if (iEsaCAR>0)
        {
            CreateItemOnObject("NW_IT_MPOTION009", oPJ, 10);
        }//Carismatico.
    }//fin clerigo.

    //--------------------------------------------------------------------->
    if (GetLevelByClass(CLASS_TYPE_DRUID, oPJ) >= 1)
    {
        CreateItemOnObject("tx_gen_druida", oPJ);
        CreateItemOnObject("tx_gen_lanza", oPJ);
        CreateItemOnObject("NW_IT_MPOTION009", oPJ, 10);
        if (iEsaINT>0)
        {
            CreateItemOnObject("NW_IT_MPOTION002", oPJ, 10);
            CreateItemOnObject("NW_IT_MPOTION006", oPJ, 10);
            CreateItemOnObject("bebe_sidra", oPJ, 10);
            CreateItemOnObject("NW_IT_MPOTION005", oPJ, 10);
        }//Listo.
        if (iEsaCAR>0)
        {
            CreateItemOnObject("tx_gen_honda", oPJ);
            CreateItemOnObject("tx_gen_piedra", oPJ, 99);
            CreateItemOnObject("tx_gen_piedra", oPJ, 99);
            CreateItemOnObject("tx_gen_piedra", oPJ, 99);
            CreateItemOnObject("tx_gen_piedra", oPJ, 99);
            CreateItemOnObject("tx_gen_baston", oPJ);
            CreateItemOnObject("NW_IT_MPOTION020",oPJ, 10);
        }//Carismatico.
    }//fin druida.

    //--------------------------------------------------------------------->
    if (GetLevelByClass(CLASS_TYPE_FIGHTER, oPJ) >= 1)
    {

        CreateItemOnObject("tx_esc_grande", oPJ);
        CreateItemOnObject("tx_cotamallas_01", oPJ);
        CreateItemOnObject("tx_gen_daga", oPJ);
        CreateItemOnObject("tx_gen_esp_corta", oPJ);
        //Armadura para mediano
        if(GetRacialType(oPJ)== IP_CONST_RACIALTYPE_HALFLING)
        {

            DestroyObject(GetObjectByTag("tx_cotamallas_01"));
            CreateItemOnObject("tx_cuero_01", oPJ);
        }

        //Bloque Arma Primaria.
        string sNombre = GetName(oPJ);
        string sJugador = GetPCPlayerName(oPJ);
        int iArmaPrimaria = GetLocalInt(oPJ, "arma_"+sNombre+"_"+sJugador);
        //Miramos Comprobacion.
        switch(iArmaPrimaria)
        {
            case 1: //Alabarda.
            {
                CreateItemOnObject("tx_gen_alabarda", oPJ);
                break;
            }//Fin Alabarda.
            case 2: //Guadaña.
            {
                CreateItemOnObject("tx_gen_guada", oPJ);
                break;
            }//Fin Guadaña.
            case 3: //Lanza
            {
                CreateItemOnObject("tx_gen_lanza", oPJ);
                break;
            }//Fin Lanza.
            case 4: //Mangual Pesado.
            {
                CreateItemOnObject("tx_gen_man_pesa", oPJ);
                break;
            }//Fin Mangual Pesado.
            case 5: ////Martillo de Guerra
            {
                CreateItemOnObject("tx_gen_marti_pes", oPJ);
                break;
            }//Fin //Fin Martillo de Guerra..
            case 6://Maza.
            {
                CreateItemOnObject("tx_gen_maza", oPJ);
                break;
            }//Fin Maza.
            case 7: //Maza de Armas.
            {
                CreateItemOnObject("tx_gen_baston", oPJ);
                break;
            }//Fin Maza de Armas.
            case 8: //Bastón.
            {
                CreateItemOnObject("tx_gen_doshojas", oPJ);
                break;
            }//Fin Bastón.
            case 9: //Espada de Doble Hoja.
            {
                CreateItemOnObject("tx_gen_alabarda", oPJ);
                break;
            }//Fin Espada de Doble Hoja.
            case 10: //Hacha Doble.
            {
                CreateItemOnObject("tx_gen_hacha_dos", oPJ);
                break;
            }//Fin Hacha Doble.
            case 11: //Espada Corta.
            {
                CreateItemOnObject("tx_gen_esp_corta", oPJ);
                break;
            }//Fin Espada Corta.
            case 12: //Espada Larga.
            {
                CreateItemOnObject("tx_gen_esp_larga ", oPJ);
                break;
            }//Fin Espada Larga.
            case 13: //Cimitarra.
            {
                CreateItemOnObject("tx_gen_cimitarra", oPJ);
                break;
            }//Fin Cimitarra.
            case 14: //Estoque.
            {
                CreateItemOnObject("tx_gen_estoque", oPJ);
                break;
            }//Fin Estoque.
            case 15: //Katana.
            {
                CreateItemOnObject("tx_gen_katana", oPJ);
                break;
            }//Fin Katana.
            case 16: //Hacha de Batalla.
            {
                CreateItemOnObject("tx_gen_hachabat", oPJ);
                break;
            }//Fin Hacha de Batalla.
            case 17: //Gran Hacha.
            {
                CreateItemOnObject("tx_gen_granhacha", oPJ);
                break;
            }//Fin Gran Hacha.
            case 18: //Hoz.
            {
                CreateItemOnObject("tx_gen_hoz", oPJ);
                break;
            }//Fin Hoz.
            case 19: //Kama.
            {
                CreateItemOnObject("tx_gen_kama", oPJ);
                break;
            }//Fin Kama.
            case 20: //Kukri.
            {
                CreateItemOnObject("tx_gen_kukri", oPJ);
                break;
            }//Fin Kukri.
            case 21: //Látigo.
            {
                CreateItemOnObject("tx_gen_latigo", oPJ);
                break;
            }//Fin Látigo.
            case 22: //Espadón.
            {
                CreateItemOnObject("tx_gen_espadon", oPJ);
                break;
            }//Fin Espadón.
            case 23: //Espada Bastarda.
            {
                CreateItemOnObject("tx_gen_bastarda", oPJ);
                break;
            }//Fin Espada Bastarda.
            case 24: //Hacha Enana.
            {
                CreateItemOnObject("tx_gen_hac_enana", oPJ);
                break;
            }//Fin Hacha Enana.
        }//fin switch de comprobacion de arma primaria.

        if ((iEsaINT>0)&&((GetRacialType(oPJ)== IP_CONST_RACIALTYPE_HUMAN)||(GetRacialType(oPJ)== IP_CONST_RACIALTYPE_HALFELF)))
        {
            DestroyObject(GetObjectByTag("tx_esc_grande"));
            DestroyObject(GetObjectByTag("tx_cotamallas_01"));
            CreateItemOnObject("tx_esc_paves", oPJ);
            CreateItemOnObject("tx_completa_1", oPJ);
            CreateItemOnObject("tx_cuero_01", oPJ);

        }//Listo.
        if (iEsaSAB>0)
        {
            CreateItemOnObject("tx_gen_arcolargo", oPJ);
            if ((GetRacialType(oPJ)== IP_CONST_RACIALTYPE_HALFLING)||(GetRacialType(oPJ)== IP_CONST_RACIALTYPE_DWARF)||(GetRacialType(oPJ)== IP_CONST_RACIALTYPE_GNOME))
            {
                DestroyObject(GetObjectByTag("tx_gen_arcolargo"));
                CreateItemOnObject("tx_gen_arcocorto", oPJ);
            }
            CreateItemOnObject("tx_gen_fecha", oPJ, 99);
            CreateItemOnObject("tx_gen_fecha", oPJ, 99);
            CreateItemOnObject("tx_gen_fecha", oPJ, 99);
            CreateItemOnObject("tx_gen_fecha", oPJ, 99);
        }//Astuto.
        if (iEsaCAR>0)
        {
            CreateItemOnObject("nw_it_mpotion020", oPJ, 10);
            CreateItemOnObject("nw_it_mpotion020", oPJ, 10);
            CreateItemOnObject("come_fruta_1", oPJ);
            CreateItemOnObject("come_huevos", oPJ);
            CreateItemOnObject("come_platobueno1", oPJ);
            CreateItemOnObject("come_platobueno2", oPJ);
            CreateItemOnObject("come_tarta", oPJ);
            CreateItemOnObject("bebe_grog", oPJ, 10);
        }//Carismatico.
        if ((iEsaINT>0)&&(iEsaSAB>0)&&(iEsaCAR>0)&&(GetRacialType(oPJ)==IP_CONST_RACIALTYPE_DWARF))
        {
            DestroyObject(GetObjectByTag("tx_esc_grande"));
            DestroyObject(GetObjectByTag("tx_cotamallas_01"));
            CreateItemOnObject("tx_completa_02", oPJ);
            CreateItemOnObject("tx_esc_grande_02", oPJ);
            CreateItemOnObject("tx_cuero_01", oPJ);
            iExperienciaInicial = iExperienciaInicial + 5000;
            SetXP(oPJ, iExperienciaInicial);
        }//fin de un enano como dios manda.
    }//fin guerrero.

    //--------------------------------------------------------------------->
    if (GetLevelByClass(CLASS_TYPE_MONK, oPJ) >= 1)
    {
        CreateItemOnObject("tx_gen_monje", oPJ);
        CreateItemOnObject("tx_gen_kama", oPJ);
        CreateItemOnObject("tx_gen_shuriken", oPJ, 50);
        CreateItemOnObject("tx_gen_shuriken", oPJ, 50);
        CreateItemOnObject("tx_gen_shuriken", oPJ, 50);
        CreateItemOnObject("tx_gen_shuriken", oPJ, 50);
        if (iEsaINT>0)
        {
            CreateItemOnObject("tx_gen_shuriken", oPJ, 50);
            CreateItemOnObject("tx_gen_shuriken", oPJ, 50);
            CreateItemOnObject("tx_gen_shuriken", oPJ, 50);
            CreateItemOnObject("tx_gen_shuriken", oPJ, 50);
        }//Listo.
        if (iEsaCAR>0)
        {
            CreateItemOnObject("NW_IT_MPOTION020", oPJ, 10);
            CreateItemOnObject("NW_IT_MPOTION020", oPJ, 10);
        }//Carismatico.
    }//fin monje.

    //--------------------------------------------------------------------->
    if (GetLevelByClass(CLASS_TYPE_PALADIN, oPJ) >= 1)
    {
        CreateItemOnObject("tx_esc_grande", oPJ);
        CreateItemOnObject("tx_cotamallas_01", oPJ);
        CreateItemOnObject("tx_gen_daga", oPJ);
        CreateItemOnObject("tx_gen_esp_corta", oPJ);
        CreateItemOnObject("tx_gen_esp_larga", oPJ);
        if ((iEsaINT>0)&&((GetRacialType(oPJ)== IP_CONST_RACIALTYPE_HUMAN)||(GetRacialType(oPJ)== IP_CONST_RACIALTYPE_HALFELF)))
        {
            DestroyObject(GetObjectByTag("tx_esc_grande"));
            DestroyObject(GetObjectByTag("tx_cotamallas_01"));
            CreateItemOnObject("tx_esc_paves", oPJ);
            CreateItemOnObject("tx_gen_guerrero", oPJ);
            CreateItemOnObject("tx_cuero_01", oPJ);
        }//Listo.
        if (iEsaSAB>0)
        {
            CreateItemOnObject("tx_gen_espadon", oPJ);
            if ((GetRacialType(oPJ)== IP_CONST_RACIALTYPE_HALFLING)||(GetRacialType(oPJ)== IP_CONST_RACIALTYPE_DWARF)||(GetRacialType(oPJ)== IP_CONST_RACIALTYPE_GNOME))
            {
                DestroyObject(GetObjectByTag("tx_gen_espadon"));
                CreateItemOnObject("tx_gen_estoque");
            }
        }//Astuto.
        if (iEsaCAR>2)
        {
            DestroyObject(GetObjectByTag("tx_cotamallas_01"));
            DestroyObject(GetObjectByTag("tx_gen_guerrero"));
            CreateItemOnObject("tx_gen_paladin", oPJ);
        }//Carismatico.
    }//fin paladin.

    //--------------------------------------------------------------------->
    if (GetLevelByClass(CLASS_TYPE_RANGER, oPJ) >= 1)
    {
        CreateItemOnObject("tx_gen_arcolargo", oPJ);
        CreateItemOnObject("tx_gen_fecha", oPJ, 99);
        CreateItemOnObject("tx_gen_fecha", oPJ, 99);
        CreateItemOnObject("tx_gen_fecha", oPJ, 99);
        CreateItemOnObject("tx_gen_fecha", oPJ, 99);
        CreateItemOnObject("tx_gen_explora", oPJ);
        CreateItemOnObject("tx_gen_lanza", oPJ);
        if (iEsaINT>0)
        {
            CreateItemOnObject("tx_gen_estoque", oPJ);
            CreateItemOnObject("tx_gen_esp_corta", oPJ);
            CreateItemOnObject("tx_gen_esp_larga", oPJ);
            CreateItemOnObject("NW_IT_MPOTION020", oPJ, 10);
            CreateItemOnObject("NW_IT_MPOTION002", oPJ, 10);
        }//Listo.
        if (iEsaSAB>0)
        {
            CreateItemOnObject("come_fruta_1",oPJ);
            CreateItemOnObject("come_frutossecos",oPJ);
            CreateItemOnObject("come_fruta_1",oPJ);
            CreateItemOnObject("come_frutossecos",oPJ);
            CreateItemOnObject("come_trucha",oPJ);
            CreateItemOnObject("come_trucha",oPJ);
            CreateItemOnObject("bebe_sidra", oPJ, 10);
        }//Astuto.
        if (iEsaCAR>0)
        {
            CreateItemOnObject("NW_IT_MPOTION011", oPJ, 5);
            CreateItemOnObject("NW_IT_MPOTION006", oPJ, 5);
        }//Carismatico.
    }//fin explorador.

    //--------------------------------------------------------------------->
    if (GetLevelByClass(CLASS_TYPE_ROGUE, oPJ) >= 1)
    {
        CreateItemOnObject("tx_gen_daga", oPJ);
        CreateItemOnObject("tx_gen_esp_corta", oPJ);
        CreateItemOnObject("tx_cuero_01", oPJ);
        CreateItemOnObject("tx_gen_arcocorto", oPJ);
        CreateItemOnObject("tx_gen_fecha", oPJ, 99);
        CreateItemOnObject("tx_gen_fecha", oPJ, 99);
        CreateItemOnObject("tx_gen_fecha", oPJ, 99);
        CreateItemOnObject("tx_gen_fecha", oPJ, 99);
        if (iEsaINT>0)
        {
            CreateItemOnObject("NW_IT_MPOTION001", oPJ, 10);
            CreateItemOnObject("NW_IT_MPOTION020", oPJ, 10);
            CreateItemOnObject("NW_IT_MPOTION002", oPJ, 10);
        }//Listo.
        if (iEsaSAB>0)
        {
            CreateItemOnObject("tx_gen_dg_ladron", oPJ);
            CreateItemOnObject("NW_IT_MPOTION005", oPJ, 10);
            CreateItemOnObject("NW_IT_MPOTION004", oPJ, 10);
        }//Astuto.
        if (iEsaCAR>0)
        {
            DestroyObject(GetObjectByTag("tx_cuero_01"));
            CreateItemOnObject("tx_gen_ladron", oPJ);
            CreateItemOnObject("NW_IT_MPOTION011", oPJ, 3);
            CreateItemOnObject("bebe_diablorojo", oPJ, 10);
        }//Carismatico.
    }//fin picaro.

    //--------------------------------------------------------------------->
    if (GetLevelByClass(CLASS_TYPE_SORCERER, oPJ) >= 1)
    {
        CreateItemOnObject("tx_gen_hechicero", oPJ);
        CreateItemOnObject("tx_gen_maz_hechi", oPJ);
        CreateItemOnObject("tx_gen_ball_leve", oPJ);
        CreateItemOnObject("tx_gen_virote", oPJ, 99);
        CreateItemOnObject("tx_gen_virote", oPJ, 99);
        CreateItemOnObject("tx_gen_virote", oPJ, 99);
        CreateItemOnObject("tx_gen_virote", oPJ, 99);
        if (iEsaINT>0)
        {
            CreateItemOnObject("tx_cetroescarcha", oPJ);
            CreateItemOnObject("NW_IT_MPOTION002", oPJ, 10);
        }//Listo.
        if (iEsaSAB>0)
        {
            CreateItemOnObject("NW_IT_MPOTION011", oPJ, 3);
            CreateItemOnObject("NW_IT_MPOTION006", oPJ, 3);
        }//Astuto.
    }//fin hechicero.

    //--------------------------------------------------------------------->
    if (GetLevelByClass(CLASS_TYPE_WIZARD, oPJ) >= 1)
    {
        CreateItemOnObject("tx_gen_mago", oPJ);
        CreateItemOnObject("tx_gen_dg_mago", oPJ);
        CreateItemOnObject("tx_gen_baston", oPJ);
        CreateItemOnObject("tx_cetroescarcha", oPJ);
        if (iEsaCAR>0)
        {
            CreateItemOnObject("NW_IT_MPOTION020", oPJ, 10);
        }//Carismatico.
    }//fin mago.
    //--------------------------------------------------------------------->

    //Identificamos el equipo inicial del aventurero.
    object oPiezaEquipo = GetFirstItemInInventory(oPJ);
    while (GetIsObjectValid(oPiezaEquipo))
    {
        SetIdentified(oPiezaEquipo, IP_CONST_CASTSPELL_IDENTIFY_3);
        oPiezaEquipo = GetNextItemInInventory(oPJ);
    }//fin del while de identificacion de equipo.

    // Saltar al punto de inicio.
    AssignCommand(GetPCSpeaker(), ClearAllActions());
    AssignCommand(GetPCSpeaker(), JumpToObject(GetObjectByTag("1_mundo_inicio")));

}//Fin del Cuerpo Principal.
