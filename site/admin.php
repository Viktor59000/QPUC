<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QPUC - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/background.css">
    <style>
        .table-dark {
            --bs-table-bg: transparent;
            --bs-table-color: #fff;
            --bs-table-hover-bg: rgba(255,255,255,0.05);
        }
        .form-control-dark {
            background-color: rgba(255,255,255,0.1);
            border-color: rgba(255,255,255,0.2);
            color: white;
        }
        .form-control-dark:focus {
            background-color: rgba(255,255,255,0.15);
            border-color: var(--color-gold);
            color: white;
            box-shadow: none;
        }
    </style>
</head>
<body>
    <!-- Simple CSS Background -->
    <div class="animated-bg"></div>

    <!-- Admin Navbar -->
    <nav class="navbar navbar-dark bg-transparent border-bottom border-secondary fixed-top glass-panel rounded-0">
        <div class="container-fluid">
            <span class="navbar-brand mb-0 h1 text-gold">QPUC <span class="text-white fs-6">| BackOffice</span></span>
            <div class="d-flex align-items-center text-white">
                <span class="me-3">Admin User</span>
                <a href="index.php" class="btn btn-sm btn-outline-light">Voir le site</a>
            </div>
        </div>
    </nav>

    <div class="container main-content py-5 mt-5">
        
        <!-- Dashboard Stats -->
        <div class="row g-4 mb-5">
            <div class="col-md-4">
                <div class="glass-panel p-4 d-flex align-items-center">
                    <div class="bg-primary bg-opacity-25 p-3 rounded-circle me-3">
                        <i class="fas fa-users fa-2x text-primary"></i>
                    </div>
                    <div>
                        <h6 class="text-white-50 mb-1">Inscrits Totaux</h6>
                        <h2 class="mb-0 text-white">1,248</h2>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="glass-panel p-4 d-flex align-items-center">
                    <div class="bg-success bg-opacity-25 p-3 rounded-circle me-3">
                        <i class="fas fa-check-circle fa-2x text-success"></i>
                    </div>
                    <div>
                        <h6 class="text-white-50 mb-1">Parties Jouées</h6>
                        <h2 class="mb-0 text-white">8,502</h2>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="glass-panel p-4 d-flex align-items-center">
                    <div class="bg-warning bg-opacity-25 p-3 rounded-circle me-3">
                        <i class="fas fa-question fa-2x text-warning"></i>
                    </div>
                    <div>
                        <h6 class="text-white-50 mb-1">Questions Actives</h6>
                        <h2 class="mb-0 text-white">350</h2>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <!-- User List -->
            <div class="col-lg-8 mb-4">
                <div class="glass-panel p-4 h-100">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h4 class="text-white mb-0">Utilisateurs</h4>
                        <div class="input-group w-auto">
                            <input type="text" class="form-control form-control-sm form-control-dark" placeholder="Rechercher...">
                            <button class="btn btn-sm btn-outline-light"><i class="fas fa-search"></i></button>
                        </div>
                    </div>
                    
                    <div class="table-responsive">
                        <table class="table table-dark table-hover align-middle">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Pseudo</th>
                                    <th>Email</th>
                                    <th>Score Max</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>1</td>
                                    <td><img src="https://ui-avatars.com/api/?name=John+Doe&background=random" class="rounded-circle me-2" width="30"> JohnDoe</td>
                                    <td>john@example.com</td>
                                    <td><span class="badge bg-gold text-dark">850 pts</span></td>
                                    <td>
                                        <button class="btn btn-sm btn-link text-white"><i class="fas fa-edit"></i></button>
                                        <button class="btn btn-sm btn-link text-danger"><i class="fas fa-trash"></i></button>
                                    </td>
                                </tr>
                                <tr>
                                    <td>2</td>
                                    <td><img src="https://ui-avatars.com/api/?name=Alice+Smith&background=random" class="rounded-circle me-2" width="30"> AliceS</td>
                                    <td>alice@example.com</td>
                                    <td><span class="badge bg-secondary">320 pts</span></td>
                                    <td>
                                        <button class="btn btn-sm btn-link text-white"><i class="fas fa-edit"></i></button>
                                        <button class="btn btn-sm btn-link text-danger"><i class="fas fa-trash"></i></button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Question CRUD -->
            <div class="col-lg-4 mb-4">
                <div class="glass-panel p-4 h-100">
                    <h4 class="text-white mb-4">Ajouter une Question</h4>
                    <form>
                        <div class="mb-3">
                            <label class="form-label text-white-50">Intitulé</label>
                            <textarea class="form-control form-control-dark" rows="3" placeholder="Ex: Quelle est la capitale..."></textarea>
                        </div>
                        <div class="mb-3">
                            <label class="form-label text-white-50">Bonne Réponse</label>
                            <input type="text" class="form-control form-control-dark bg-success bg-opacity-10 border-success" placeholder="Réponse Correcte">
                        </div>
                        <div class="mb-3">
                            <label class="form-label text-white-50">Mauvaises Réponses</label>
                            <input type="text" class="form-control form-control-dark mb-2" placeholder="Faux 1">
                            <input type="text" class="form-control form-control-dark mb-2" placeholder="Faux 2">
                            <input type="text" class="form-control form-control-dark" placeholder="Faux 3">
                        </div>
                        <div class="mb-3">
                            <label class="form-label text-white-50">Difficulté</label>
                            <select class="form-select form-control-dark">
                                <option>Facile (1 pt)</option>
                                <option>Moyen (3 pts)</option>
                                <option>Difficile (5 pts)</option>
                            </select>
                        </div>
                        <button type="button" class="btn btn-primary-glass w-100">Enregistrer</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="js/cursor.js"></script>
</body>
</html>
