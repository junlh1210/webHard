<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <!-- favicon -->
    <link rel="shortcut icon" type="image/x-icon" href="/resources/favicon.ico" />

    <!-- jquery -->
    <script type="text/javascript" src="resources/js/jquery-3.5.1.min.js"></script>

    <!-- toast grid -->
    <link rel="stylesheet" href="/resources/tui-grid/tui-grid.css" />
    <script type="text/javascript" src="/resources/tui-grid/tui-grid.js"></script>

    <!-- bootstrap -->
    <link rel="stylesheet" href="/resources/css/bootstrap.css" />
    <script type="text/javascript" src="/resources/js/bootstrap.js"></script>
    
    <!-- fontawesome-free -->
    <link rel="stylesheet" href="/resources/css/all.min.css" />

    <!-- Custom styles for this template-->
    <link href="/resources/css/sb-admin-2.min.css" rel="stylesheet" />
    
    <!-- common.js -->
    <script type="text/javascript" src="/resources/js/common.js"></script>
    
    <script type="text/javascript">
      function showLoad(title, url) {
        $("#contents_title").html(title);
        $("#frame").load(url, function (response, status) {
          if (status == "error") {
            $("#frame").html(response);
          }
        });
      }
    
    </script>

    <title>빨리어서와</title>
  </head>
  <body id="top">
    <div id="wrapper">
      <!-- Sidebar -->
      <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">
        <!-- Sidebar - Brand -->
        <a class="sidebar-brand d-flex align-items-center justify-content-center" href="/">
          <div class="sidebar-brand-icon">
            <img src="/resources/img/erion.png" alt="avatar image" srcset="" style="width: 32px" />
          </div>
          <div class="sidebar-brand-text mx-3 userName">유저닉네임으로 교체</div>
        </a>

        <!-- Divider -->
        <hr class="sidebar-divider my-0" />

        <!-- Nav Item - Dashboard -->
		<li class="nav-item active">
          <a class="nav-link" href="#">
            <i class="fas fa-clipboard-list"></i>
            <span>환경은 ${sessionScope.ServerInfo}</span>
          </a>
        </li>
        
        <!-- Divider -->
        <hr class="sidebar-divider my-0" />
       
        <!-- Nav Item - Dashboard -->
        <!-- Nav Item - Pages Collapse Menu -->
        
        <li class="nav-item">
          <a
            class="nav-link collapsed"
            href="#"
            data-toggle="collapse"
            data-target="#board"
            aria-expanded="true"
            aria-controls="board"
          >
            <i class="fas fa-chalkboard-teacher"></i>
            <span id="menuName1">메뉴종류 넣기</span>
          </a>
          <div id="board" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
            
			<!-- DB에서 가져온 메뉴가 들어간다. -->
			
          <!-- 
              <a class="collapse-item">
                <span
                  onClick="javascript:showLoad('전체게시판', '/board/all/1');"
                  style="cursor: pointer; cursor: hand"
                >
                  <i class="fas fa-list"></i>&nbsp;&nbsp;전체게시판
                </span>
              </a>
              <a class="collapse-item">
                <span
                  onClick="javascript:showLoad('공지사항', '/board/notice/1');"
                  style="cursor: pointer; cursor: hand"
                >
                  <i class="fas fa-list"></i>&nbsp;&nbsp;공지사항
                </span>
              </a>
              <a class="collapse-item">
                <span
                  onClick="javascript:showLoad('자유게시판', '/board/free/1');"
                  style="cursor: pointer; cursor: hand"
                >
                  <i class="fas fa-list"></i>&nbsp;&nbsp;자유게시판
                </span>
              </a>
              <a class="collapse-item">
                <span
                  onClick="javascript:showLoad('Q&A게시판', '/board/qna/1');"
                  style="cursor: pointer; cursor: hand"
                >
                  <i class="fas fa-list"></i>&nbsp;&nbsp;Q&amp;A
                </span>
              </a>
         -->
         
            </div>
          </div>
        </li>
        
        <!-- Divider -->
        <hr class="sidebar-divider" />

        <!-- Heading -->
        <!-- <div class="sidebar-heading">
          SI 웹개발자 과정 
        </div> -->

        <!-- Nav Item - Pages Collapse Menu -->
        <li class="nav-item">
          <a
            class="nav-link collapsed"
            href="#"
            data-toggle="collapse"
            data-target="#collapseTwo"
            aria-expanded="true"
            aria-controls="collapseTwo"
          >
            <i class="fas fa-chalkboard-teacher"></i>
            <span>SI웹개발자 과정</span>
          </a>
          <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
              <!-- <h6 class="collapse-header">Custom Components:</h6> -->
              <a class="collapse-item">
                <span
                  onClick="javascript:showLoad('SI 웹개발자 과정  3기', '/study03');"
                  style="cursor: pointer; cursor: hand"
                  ><i class="fas fa-user-graduate"></i>&nbsp;&nbsp;3기</span
                >
              </a>
              <a class="collapse-item">
                <span
                  onClick="javascript:showLoad('SI 웹개발자 과정  2기', '/study02');"
                  style="cursor: pointer; cursor: hand"
                  ><i class="fas fa-user-graduate"></i>&nbsp;&nbsp;2기</span
                >
              </a>
              <a class="collapse-item">
                <span
                  onClick="javascript:showLoad('SI 웹개발자 과정  1기', '/study01');"
                  style="cursor: pointer; cursor: hand"
                  ><i class="fas fa-user-graduate"></i>&nbsp;&nbsp;1기</span
                >
              </a>
            </div>
          </div>
        </li>

        <!-- Nav Item - Utilities Collapse Menu -->
        <li class="nav-item">
          <a
            class="nav-link collapsed"
            href="#"
            data-toggle="collapse"
            data-target="#collapseUtilities"
            aria-expanded="true"
            aria-controls="collapseUtilities"
          >
            <i class="fas fa-fw fa-wrench"></i>
            <span>Utilities</span>
          </a>
          <div
            id="collapseUtilities"
            class="collapse"
            aria-labelledby="headingUtilities"
            data-parent="#accordionSidebar"
          >
            <div class="bg-white py-2 collapse-inner rounded">
              <!-- <h6 class="collapse-header">Custom Utilities:</h6> -->
              <a class="collapse-item">
                <span onClick="javascript:showLoad('WebHard','/webhard');" style="cursor: pointer; cursor: hand">
                  <i class="fas fa-hdd"></i>&nbsp;&nbsp;WebHard
                </span>
              </a>
              <a class="collapse-item">
                <span onClick="javascript:showLoad('Book Ranking','/bookrank');" style="cursor: pointer; cursor: hand">
                  <i class="fas fa-robot"></i>&nbsp;&nbsp;Book Ranking
                </span></a>
              <!-- <a class="collapse-item" href="utilities-border.html">Borders</a>
              <a class="collapse-item" href="utilities-animation.html">Animations</a>
              <a class="collapse-item" href="utilities-other.html">Other</a> -->
            </div>
          </div>
        </li>

        <!-- Divider -->
        <hr class="sidebar-divider" />

        <!-- Heading -->
        <div class="sidebar-heading">Leacture</div>

        <!-- Nav Item - Pages Collapse Menu -->
        <li class="nav-item">
          <a
            class="nav-link collapsed"
            href="#"
            data-toggle="collapse"
            data-target="#realJava1"
            aria-expanded="true"
            aria-controls="realJava1"
          >
            <i class="fas fa-fw fa-folder"></i>
            <span>빵형의 실전 Java</span>
          </a>
          <div id="realJava1" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
              <a class="collapse-item">
                <span
                  onClick="javascript:showLoad('빵형의 실전 Java', '/leacture/realJava01');"
                  style="cursor: pointer; cursor: hand"
                >
                  <i class="fab fa-dev"></i>&nbsp;&nbsp;1장
                </span>
              </a>
              <a class="collapse-item">
                <span
                  onClick="javascript:showLoad('빵형의 실전 Java', '/leacture/realJava02');"
                  style="cursor: pointer; cursor: hand"
                >
                  <i class="fab fa-dev"></i>&nbsp;&nbsp;2장
                </span>
              </a>
              <a class="collapse-item">
                <span
                  onClick="javascript:showLoad('빵형의 실전 Java', '/leacture/realJava03');"
                  style="cursor: pointer; cursor: hand"
                >
                  <i class="fab fa-dev"></i>&nbsp;&nbsp;3장
                </span>
              </a>
              <a class="collapse-item">
                <span
                  onClick="javascript:showLoad('빵형의 실전 Java', '/realJava');"
                  style="cursor: pointer; cursor: hand"
                >
                  <i class="fab fa-dev"></i>&nbsp;&nbsp;4장
                </span>
              </a>
              <a class="collapse-item">
                <span
                  onClick="javascript:showLoad('빵형의 실전 Java', '/realJava');"
                  style="cursor: pointer; cursor: hand"
                >
                  <i class="fab fa-dev"></i>&nbsp;&nbsp;5장
                </span>
              </a>
              <a class="collapse-item">
                <span
                  onClick="javascript:showLoad('빵형의 실전 Java', '/realJava');"
                  style="cursor: pointer; cursor: hand"
                >
                  <i class="fab fa-dev"></i>&nbsp;&nbsp;6장
                </span>
              </a>
              <a class="collapse-item">
                <span
                  onClick="javascript:showLoad('빵형의 실전 Java', '/realJava');"
                  style="cursor: pointer; cursor: hand"
                >
                  <i class="fab fa-dev"></i>&nbsp;&nbsp;7장
                </span>
              </a>
              <a class="collapse-item">
                <span
                  onClick="javascript:showLoad('빵형의 실전 Java', '/realJava');"
                  style="cursor: pointer; cursor: hand"
                >
                  <i class="fab fa-dev"></i>&nbsp;&nbsp;8장
                </span>
              </a>
              <a class="collapse-item">
                <span
                  onClick="javascript:showLoad('빵형의 실전 Java', '/realJava');"
                  style="cursor: pointer; cursor: hand"
                >
                  <i class="fab fa-dev"></i>&nbsp;&nbsp;9장
                </span>
              </a>
              <a class="collapse-item">
                <span
                  onClick="javascript:showLoad('빵형의 실전 Java', '/realJava');"
                  style="cursor: pointer; cursor: hand"
                >
                  <i class="fab fa-dev"></i>&nbsp;&nbsp;10장
                </span>
              </a>
              <a class="collapse-item">
                <span
                  onClick="javascript:showLoad('빵형의 실전 Java', '/realJava');"
                  style="cursor: pointer; cursor: hand"
                >
                  <i class="fab fa-dev"></i>&nbsp;&nbsp;11장
                </span>
              </a>
              <a class="collapse-item">
                <span
                  onClick="javascript:showLoad('빵형의 실전 Java', '/realJava');"
                  style="cursor: pointer; cursor: hand"
                >
                  <i class="fab fa-dev"></i>&nbsp;&nbsp;12장
                </span>
              </a>
              <a class="collapse-item">
                <span
                  onClick="javascript:showLoad('빵형의 실전 Java', '/realJava');"
                  style="cursor: pointer; cursor: hand"
                >
                  <i class="fab fa-dev"></i>&nbsp;&nbsp;13장
                </span>
              </a>
              <a class="collapse-item">
                <span
                  onClick="javascript:showLoad('빵형의 실전 Java', '/realJava');"
                  style="cursor: pointer; cursor: hand"
                >
                  <i class="fab fa-dev"></i>&nbsp;&nbsp;14장
                </span>
              </a>
              <a class="collapse-item">
                <span
                  onClick="javascript:showLoad('빵형의 실전 Java', '/realJava');"
                  style="cursor: pointer; cursor: hand"
                >
                  <i class="fab fa-dev"></i>&nbsp;&nbsp;15장
                </span>
              </a>
              <a class="collapse-item">
                <span
                  onClick="javascript:showLoad('빵형의 실전 Java', '/realJava');"
                  style="cursor: pointer; cursor: hand"
                >
                  <i class="fab fa-dev"></i>&nbsp;&nbsp;16장
                </span>
              </a>
              <a class="collapse-item">
                <span
                  onClick="javascript:showLoad('빵형의 실전 Java', '/realJava');"
                  style="cursor: pointer; cursor: hand"
                >
                  <i class="fab fa-dev"></i>&nbsp;&nbsp;17장
                </span>
              </a>
              <a class="collapse-item">
                <span
                  onClick="javascript:showLoad('빵형의 실전 Java', '/realJava');"
                  style="cursor: pointer; cursor: hand"
                >
                  <i class="fab fa-dev"></i>&nbsp;&nbsp;18장
                </span>
              </a>
              <a class="collapse-item">
                <span
                  onClick="javascript:showLoad('빵형의 실전 Java', '/realJava');"
                  style="cursor: pointer; cursor: hand"
                >
                  <i class="fab fa-dev"></i>&nbsp;&nbsp;19장
                </span>
              </a>
              <a class="collapse-item">
                <span
                  onClick="javascript:showLoad('빵형의 실전 Java', '/realJava');"
                  style="cursor: pointer; cursor: hand"
                >
                  <i class="fab fa-dev"></i>&nbsp;&nbsp;20장
                </span>
              </a>
            </div>
          </div>
        </li>
        <li class="nav-item">
          <a
            class="nav-link collapsed"
            href="#"
            data-toggle="collapse"
            data-target="#realJava2"
            aria-expanded="true"
            aria-controls="realJava2"
          >
            <i class="fas fa-fw fa-folder"></i>
            <span>2장</span>
          </a>
          <div id="realJava2" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
              <a class="collapse-item">
                <span
                  onClick="javascript:showLoad('빵형의 실전 Java', '/realJava');"
                  style="cursor: pointer; cursor: hand"
                >
                  <i class="fab fa-dev"></i>&nbsp;&nbsp;빵형의 실전 Java #001
                </span>
              </a>
              <a class="collapse-item">
                <span
                  onClick="javascript:showLoad('빵형의 실전 Java', '/realJava');"
                  style="cursor: pointer; cursor: hand"
                >
                  <i class="fab fa-dev"></i>&nbsp;&nbsp;빵형의 실전 Java #002
                </span>
              </a>
            </div>
          </div>
        </li>

        <!-- Divider -->
        <hr class="sidebar-divider d-none d-md-block" />

        <!-- Sidebar Toggler (Sidebar) 
        <div class="text-center d-none d-md-inline">
          <button class="rounded-circle border-0" id="sidebarToggle"></button>
        </div>
        -->
      </ul>
      <!-- End of Sidebar -->

      <!-- Content Wrapper -->
      <div id="content-wrapper" class="d-flex flex-column">
        <!-- Main Content -->
        <div id="content">
          <!-- Topbar -->
          <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
            <!-- Sidebar Toggle (Topbar) -->
            <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
              <i class="fa fa-bars"></i>
            </button>

            <!-- Topbar Search -->
            <form class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
              <div class="input-group">
                <input
                  type="text"
                  class="form-control bg-light border-0 small"
                  placeholder="Search for..."
                  aria-label="Search"
                  aria-describedby="basic-addon2"
                />
                <div class="input-group-append">
                  <button class="btn btn-primary" type="button">
                    <i class="fas fa-search fa-sm"></i>
                  </button>
                </div>
              </div>
            </form>

            <!-- Topbar Navbar -->
            <ul class="navbar-nav ml-auto">
              <!-- Nav Item - Search Dropdown (Visible Only XS) -->
              <li class="nav-item dropdown no-arrow d-sm-none">
                <a
                  class="nav-link dropdown-toggle"
                  href="#"
                  id="searchDropdown"
                  role="button"
                  data-toggle="dropdown"
                  aria-haspopup="true"
                  aria-expanded="false"
                >
                  <i class="fas fa-search fa-fw"></i>
                </a>
                <!-- Dropdown - Messages -->
                <div
                  class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
                  aria-labelledby="searchDropdown"
                >
                  <form class="form-inline mr-auto w-100 navbar-search">
                    <div class="input-group">
                      <input
                        type="text"
                        class="form-control bg-light border-0 small"
                        placeholder="Search for..."
                        aria-label="Search"
                        aria-describedby="basic-addon2"
                      />
                      <div class="input-group-append">
                        <button class="btn btn-primary" type="button">
                          <i class="fas fa-search fa-sm"></i>
                        </button>
                      </div>
                    </div>
                  </form>
                </div>
              </li>

              <!-- Nav Item - Alerts -->
              <li class="nav-item dropdown no-arrow mx-1">
                <a
                  class="nav-link dropdown-toggle"
                  href="#"
                  id="alertsDropdown"
                  role="button"
                  data-toggle="dropdown"
                  aria-haspopup="true"
                  aria-expanded="false"
                >
                  <i class="fas fa-bell fa-fw"></i>
                  <!-- Counter - Alerts -->
                  <span class="badge badge-danger badge-counter">3+</span>
                </a>
                <!-- Dropdown - Alerts -->
                <div
                  class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
                  aria-labelledby="alertsDropdown"
                >
                  <h6 class="dropdown-header">Alerts Center</h6>
                  <a class="dropdown-item d-flex align-items-center" href="#">
                    <div class="mr-3">
                      <div class="icon-circle bg-primary">
                        <i class="fas fa-file-alt text-white"></i>
                      </div>
                    </div>
                    <div>
                      <div class="small text-gray-500">December 12, 2019</div>
                      <span class="font-weight-bold">A new monthly report is ready to download!</span>
                    </div>
                  </a>
                  <a class="dropdown-item d-flex align-items-center" href="#">
                    <div class="mr-3">
                      <div class="icon-circle bg-success">
                        <i class="fas fa-donate text-white"></i>
                      </div>
                    </div>
                    <div>
                      <div class="small text-gray-500">December 7, 2019</div>
                      $290.29 has been deposited into your account!
                    </div>
                  </a>
                  <a class="dropdown-item d-flex align-items-center" href="#">
                    <div class="mr-3">
                      <div class="icon-circle bg-warning">
                        <i class="fas fa-exclamation-triangle text-white"></i>
                      </div>
                    </div>
                    <div>
                      <div class="small text-gray-500">December 2, 2019</div>
                      Spending Alert: We've noticed unusually high spending for your account.
                    </div>
                  </a>
                  <a class="dropdown-item text-center small text-gray-500" href="#">Show All Alerts</a>
                </div>
              </li>

              <!-- Nav Item - Messages -->
              <li class="nav-item dropdown no-arrow mx-1">
                <a
                  class="nav-link dropdown-toggle"
                  href="#"
                  id="messagesDropdown"
                  role="button"
                  data-toggle="dropdown"
                  aria-haspopup="true"
                  aria-expanded="false"
                >
                  <i class="fas fa-envelope fa-fw"></i>
                  <!-- Counter - Messages -->
                  <span class="badge badge-danger badge-counter">7</span>
                </a>
                <!-- Dropdown - Messages -->
                <div
                  class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
                  aria-labelledby="messagesDropdown"
                >
                  <h6 class="dropdown-header">Message Center</h6>
                  <a class="dropdown-item d-flex align-items-center" href="#">
                    <div class="dropdown-list-image mr-3">
                      <img class="rounded-circle" src="https://source.unsplash.com/fn_BT9fwg_E/60x60" alt="" />
                      <div class="status-indicator bg-success"></div>
                    </div>
                    <div class="font-weight-bold">
                      <div class="text-truncate">
                        Hi there! I am wondering if you can help me with a problem I've been having.
                      </div>
                      <div class="small text-gray-500">Emily Fowler ÃÂ· 58m</div>
                    </div>
                  </a>
                  <a class="dropdown-item d-flex align-items-center" href="#">
                    <div class="dropdown-list-image mr-3">
                      <img class="rounded-circle" src="https://source.unsplash.com/AU4VPcFN4LE/60x60" alt="" />
                      <div class="status-indicator"></div>
                    </div>
                    <div>
                      <div class="text-truncate">
                        I have the photos that you ordered last month, how would you like them sent to you?
                      </div>
                      <div class="small text-gray-500">Jae Chun ÃÂ· 1d</div>
                    </div>
                  </a>
                  <a class="dropdown-item d-flex align-items-center" href="#">
                    <div class="dropdown-list-image mr-3">
                      <img class="rounded-circle" src="https://source.unsplash.com/CS2uCrpNzJY/60x60" alt="" />
                      <div class="status-indicator bg-warning"></div>
                    </div>
                    <div>
                      <div class="text-truncate">
                        Last month's report looks great, I am very happy with the progress so far, keep up the good
                        work!
                      </div>
                      <div class="small text-gray-500">Morgan Alvarez ÃÂ· 2d</div>
                    </div>
                  </a>
                  <a class="dropdown-item d-flex align-items-center" href="#">
                    <div class="dropdown-list-image mr-3">
                      <img class="rounded-circle" src="https://source.unsplash.com/Mv9hjnEUHR4/60x60" alt="" />
                      <div class="status-indicator bg-success"></div>
                    </div>
                    <div>
                      <div class="text-truncate">
                        Am I a good boy? The reason I ask is because someone told me that people say this to all dogs,
                        even if they aren't good...
                      </div>
                      <div class="small text-gray-500">Chicken the Dog ÃÂ· 2w</div>
                    </div>
                  </a>
                  <a class="dropdown-item text-center small text-gray-500" href="#">Read More Messages</a>
                </div>
              </li>

              <div class="topbar-divider d-none d-sm-block"></div>

              <!-- Nav Item - User Information -->
              <li class="nav-item dropdown no-arrow">
                <a
                  class="nav-link dropdown-toggle"
                  href="#"
                  id="userDropdown"
                  role="button"
                  data-toggle="dropdown"
                  aria-haspopup="true"
                  aria-expanded="false"
                >
                  <span class="mr-2 d-none d-lg-inline text-gray-600 small userName">유저닉네임으로 교체</span>
                  <img class="img-profile rounded-circle" src="/resources/img/erion.png" style="width: 32px" />
                </a>
                <!-- Dropdown - User Information -->
                <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
                  <a class="dropdown-item" href="#">
                    <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                    Profile
                  </a>
                  <a class="dropdown-item" href="#">
                    <i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>
                    Settings
                  </a>
                  <a class="dropdown-item" href="#">
                    <i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>
                    Activity Log
                  </a>
                  <div class="dropdown-divider"></div>
                  <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                    <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                    Logout
                  </a>
                </div>
              </li>
            </ul>
          </nav>
          <!-- End of Topbar -->

          <!-- Begin Page Content -->
          <div class="container-fluid">
            <!-- Page Heading -->
            <div class="d-sm-flex align-items-center justify-content-between mb-2">
              <h1 class="h3 mb-0 text-gray-800" id="contents_title">Dashboard</h1>
              <!-- 
              <a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i class="fas fa-download fa-sm text-white-50"></i> Generate Report</a>
              <nav aria-label="breadcrumb">
              -->
              
              <!-- 
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="#">Home</a></li>
                <li class="breadcrumb-item"><a href="#">Library</a></li>
                <li class="breadcrumb-item active" aria-current="page">Data</li>
              </ol>
              -->
              <div id="DIR_REALNAME">DB경로가 표시되야 함</div>
            </div>

            <!-- Content Row -->
            <div class="row">
              <!-- Content Column -->
              <div class="col-lg-12 mb-2">
                <!-- Project Card Example -->
                <div class="card shadow mb-2">
                  <!-- <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-primary">Projects</h6>
                  </div> -->
                  <div class="card-body" id="frame">
                    <h4 class="small font-weight-bold">Server Migration <span class="float-right">20%</span></h4>
                    <div class="progress mb-4">
                      <div
                        class="progress-bar bg-danger"
                        role="progressbar"
                        style="width: 20%"
                        aria-valuenow="20"
                        aria-valuemin="0"
                        aria-valuemax="100"
                      ></div>
                    </div>
                    <h4 class="small font-weight-bold">Sales Tracking <span class="float-right">40%</span></h4>
                    <div class="progress mb-4">
                      <div
                        class="progress-bar bg-warning"
                        role="progressbar"
                        style="width: 40%"
                        aria-valuenow="40"
                        aria-valuemin="0"
                        aria-valuemax="100"
                      ></div>
                    </div>
                    <h4 class="small font-weight-bold">Customer Database <span class="float-right">60%</span></h4>
                    <div class="progress mb-4">
                      <div
                        class="progress-bar"
                        role="progressbar"
                        style="width: 60%"
                        aria-valuenow="60"
                        aria-valuemin="0"
                        aria-valuemax="100"
                      ></div>
                    </div>
                    <h4 class="small font-weight-bold">Payout Details <span class="float-right">80%</span></h4>
                    <div class="progress mb-4">
                      <div
                        class="progress-bar bg-info"
                        role="progressbar"
                        style="width: 80%"
                        aria-valuenow="80"
                        aria-valuemin="0"
                        aria-valuemax="100"
                      ></div>
                    </div>
                    <h4 class="small font-weight-bold">Account Setup <span class="float-right">Complete!</span></h4>
                    <div class="progress">
                      <div
                        class="progress-bar bg-success"
                        role="progressbar"
                        style="width: 100%"
                        aria-valuenow="100"
                        aria-valuemin="0"
                        aria-valuemax="100"
                      ></div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <!-- /.container-fluid -->
          </div>
          <!-- End of Main Content -->

          <!-- Footer -->
          <footer class="sticky-footer bg-white">
            <div class="container my-auto">
              <div class="copyright text-center my-auto">
                <span>Copyright &copy; 빨리어서와 2021</span>
              </div>
            </div>
          </footer>
          <!-- End of Footer -->
        </div>
        <!-- End of Content Wrapper -->
      </div>
      <!-- End of Page Wrapper -->

      <!-- Scroll to Top Button-->
      <a class="scroll-to-top rounded" href="#top">
        <i class="fas fa-angle-up"></i>
      </a>

      <!-- Logout Modal-->
      <div
        class="modal fade"
        id="logoutModal"
        tabindex="-1"
        role="dialog"
        aria-labelledby="exampleModalLabel"
        aria-hidden="true"
      >
        <div class="modal-dialog" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="exampleModalLabel">로그아웃하시겠습니까?</h5>
              <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">
                  <i class="fas fa-sign-out-alt"></i>
                </span>
              </button>
            </div>
            <div class="modal-body">로그아웃 버튼을 누르면 현재 세션에서 나갑니다.</div>
            <div class="modal-footer">
              <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
              <a class="btn btn-primary" href="/nosession/logout">Logout</a>
            </div>
          </div>
        </div>
      </div>
    </div>
    <script type="text/javascript" src="/resources/js/menu.js"></script>
    <script>
    $(document).ready(function(){
		$("#DIR_REALNAME").text('${sessionScope.authUser.DIR_REALNAME}');
		$(".userName").text('${sessionScope.authUser.NICK_NAME}');
		
		util.requestSync('/menuList', '', 'GET', function(results) {
			const menuArray = makeMenuArray(results);
		    const ul = document.querySelector('ul#accordionSidebar');
		    menuArray.forEach(i => {
		        ul.insertAdjacentHTML('beforeend', makeMenu(i));
		    });
		});
    });
    </script>
  </body>
</html>
